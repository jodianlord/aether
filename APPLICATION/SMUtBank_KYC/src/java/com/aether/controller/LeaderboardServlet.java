/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;
import java.net.*;
import org.json.*;

/**
 *
 * @author Chuanyi
 */
@WebServlet(name = "LeaderboardServlet", urlPatterns = {"/LeaderboardServlet"})
public class LeaderboardServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            boolean verbose = true;

            //api url
            String apiServiceUrl = "http://tbankonline.com/SMUtBank_API/Gateway";

            String serviceRespTag = "Get_Game_Leaders_ReadResponse";
            String globalErrorID;
            String errorText;
            Object errorDetails;
            String score;
            String user_Id;

            String serviceName = "getGameLeaders";
            String userID = "";
            String PIN = "";
            String OTP = "";
            String gameID = "1";
            String start = "2010-01-01 00:00:00";
            String end = "2019-01-01 23:59:59";
            String mode = "*";
            String byGroup = "true";

            try {
                //building of header
                JSONObject jo = new JSONObject();
                jo.put("serviceName", serviceName);
                jo.put("userID", userID);
                jo.put("PIN", PIN);
                jo.put("OTP", OTP);
                JSONObject headerObj = new JSONObject();
                headerObj.put("Header", jo);
                String header = headerObj.toString();

                //building of content
                jo = new JSONObject();
                jo.put("gameID", gameID);
                jo.put("start", start);
                jo.put("end", end);
                jo.put("mode", mode);
                jo.put("byGroup", byGroup);
                JSONObject contentObj = new JSONObject();
                contentObj.put("Content", jo);
                String content = contentObj.toString();

                //Connect to the API Service
                HttpURLConnection urlConnection = (HttpURLConnection) new URL(apiServiceUrl).openConnection();
                urlConnection.setDoOutput(true);
                urlConnection.setRequestMethod("POST");

                //build request parameters
                String parameters = "Header=" + header + "&" + "Content=" + content;

                //sending of the request
                BufferedWriter br = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
                br.write(parameters);
                br.close();

                //getting the response
                String response1 = "";
                Scanner s = new Scanner(urlConnection.getInputStream());
                while (s.hasNextLine()) {
                    response1 += s.nextLine();
                }
                s.close();

                //getting the response object
                boolean apiError;
                JSONObject responseObj = new JSONObject(response1);
                responseObj = new JSONObject(response1);

                if (verbose) {
                    System.out.println(responseObj.toString(4));
                    System.out.println();
                }

                //parsing of content
                contentObj = responseObj.getJSONObject("Content");

                //parsing of the service Response
                JSONObject serviceRespObj = contentObj.getJSONObject("ServiceResponse");

                // parsing the service response header
                JSONObject serviceRespHeaderObj = serviceRespObj.getJSONObject("ServiceRespHeader");
                globalErrorID = serviceRespHeaderObj.getString("GlobalErrorID");
                errorText = serviceRespHeaderObj.getString("ErrorText");
                errorDetails = serviceRespHeaderObj.get("ErrorDetails");

                if (!globalErrorID.equals("010000")) {
                    System.out.println(errorText);
                    System.out.println(errorDetails);
                } else {
                    JSONObject leaderObj = serviceRespObj.getJSONObject("LeaderDetails");
                    JSONObject leaderObj2 = leaderObj.getJSONObject("Leaders");
                    Object testObj = leaderObj2.get("Leader");
                    if (testObj instanceof JSONArray) {
                        JSONArray ldrObj = leaderObj2.getJSONArray("Leader");

                        out.println(ldrObj.toString());

                        /*for (int i = 0; i < ldrObj.length(); i++) {
                        JSONObject ldrobj = ldrObj.getJSONObject(i);
                        score = ldrobj.getString("score");
                        user_Id = ldrobj.getString("user_Id");

                        System.out.println("score = " + score);
                        System.out.println("user_id = " + user_Id);
                    }*/
                    } else if (testObj instanceof JSONObject) {
                        JSONObject ldrObj = leaderObj2.getJSONObject("Leader");

                        out.println(ldrObj.toString());

                        /*score = ldrObj.getString("score");
                    user_Id = ldrObj.getString("user_Id");

                    System.out.println("score = " + score);
                    System.out.println("user_id = " + user_Id);*/
                        out.println(ldrObj.toString());

                    } else {
                        System.out.println("No record");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
