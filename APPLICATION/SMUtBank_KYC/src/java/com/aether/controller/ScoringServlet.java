/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import com.aether.dao.QuestionDAO;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Yuefeng
 */
@WebServlet(name = "ScoringServlet", urlPatterns = {"/ScoringServlet"})
public class ScoringServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

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
        response.setContentType("application/json");

        String apiServiceUrl = "http://tbankonline.com/SMUtBank_API/Gateway";
        String body = getBody(request);
        boolean verbose = true;

        try (PrintWriter out = response.getWriter()) {
            org.json.simple.JSONObject resultJSON = new org.json.simple.JSONObject();
            boolean result = false;
            org.json.simple.JSONObject jsonContent = getJSONObject(body);
            
            //System.out.println(jsonContent);
            int timeOne = Integer.parseInt(jsonContent.get("pageNo4").toString());
            int timeTwo = Integer.parseInt(jsonContent.get("pageNo5").toString());
            int timeThree = Integer.parseInt(jsonContent.get("pageNo6").toString());
            int scoreA = 1000 - timeOne;
            int scoreB = 1000 - timeTwo;
            int scoreC = 1000 - timeThree;
            //getting questionID
            String qIDOne = jsonContent.get("qnsA").toString();
            String qIDTwo = jsonContent.get("qnsB").toString();
            String qIDThree = jsonContent.get("qnsC").toString();

            JSONObject qObj = new JSONObject();
            qObj.put("1", qIDOne);
            qObj.put("2", qIDTwo);
            qObj.put("3", qIDThree);

            String qAnswerOne = "";
            String qAnswerTwo = "";
            String qAnswerThree = "";

            QuestionDAO qnsDAO = new QuestionDAO();
            JSONObject getQnsAns = qnsDAO.getQuestionAnswer(qIDOne);
            if (getQnsAns != null) {
                qAnswerOne = getQnsAns.getString("answer");
                System.out.print("qqqqq"+qAnswerOne);
                String correctAns = jsonContent.get("questionID-" + qIDOne).toString();
                if (qAnswerOne.equals(correctAns)) {
                    scoreA += 100;
                }
            }
            getQnsAns = qnsDAO.getQuestionAnswer(qIDTwo);
            if (getQnsAns != null) {
                qAnswerTwo = getQnsAns.getString("answer");
                String correctAns = jsonContent.get("questionID-" + qIDTwo).toString();
                if (qAnswerTwo.equals(correctAns)) {
                    scoreB += 100;
                }
            }
            getQnsAns = qnsDAO.getQuestionAnswer(qIDThree);
            if (getQnsAns != null) {
                qAnswerThree = getQnsAns.getString("answer");
                String correctAns = jsonContent.get("questionID-" + qIDThree).toString();
                if (qAnswerThree.equals(correctAns)) {
                    scoreC += 100;
                }
            }
            JSONObject scoreObj = new JSONObject();
            scoreObj.put("1", scoreA + "");
            scoreObj.put("2", scoreB + "");
            scoreObj.put("3", scoreC + "");

            //request parameters
            String serviceRespTag = "Set_Question_Score_ReadResponse";
            String globalErrorID;
            String errorText;
            String status;

            String serviceName = "setQuestionScore";
            String userID = "";
            String PIN = "";
            String OTP = "";
            String gameID = "111";
            String questionID = "";
            String scoreString = "";
            String mode = "*";

            JSONObject jo = new JSONObject();
            jo.put("serviceName", serviceName);
            jo.put("userID", userID);
            jo.put("PIN", PIN);
            jo.put("OTP", OTP);
            JSONObject headerObj = new JSONObject();
            headerObj.put("Header", jo);
            String header = headerObj.toString();

            for (int i = 1; i <= 3; i++) {

                //build content
                jo = new JSONObject();
                jo.put("gameID", gameID);
                jo.put("questionID", qObj.get(""+i));
                jo.put("score", scoreObj.get(""+i) );
                jo.put("groupID", "1");
                //test
                System.out.println(qObj.get(""+i).toString() + ">>>>>>" +scoreObj.get(""+i).toString());
                jo.put("mode", mode);
                JSONObject contentObj = new JSONObject();
                contentObj.put("Content", jo);
                String content = contentObj.toString();

                //conntect to API Service
                HttpURLConnection urlConnection = (HttpURLConnection) new URL(apiServiceUrl).openConnection();
                urlConnection.setDoOutput(true);
                urlConnection.setRequestMethod("POST");

                //build request parameters
                String parameters = "Header=" + header + "&" + "Content=" + content;

                //send request
                BufferedWriter br = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
                br.write(parameters);
                br.close();

                //get response
                String outputRes = "";
                Scanner s = new Scanner(urlConnection.getInputStream());

                while (s.hasNextLine()) {
                    outputRes += s.nextLine();
                }
                s.close();

                //get reponse object
                boolean apiError;
                JSONObject responseObj = new JSONObject();
                responseObj = new JSONObject(outputRes);
                if (verbose) {
                    System.out.println(responseObj.toString(4));
                    
                    System.out.println("Entered here>>>>>>  ");
                }

                //parse {"Content"}
                contentObj = responseObj.getJSONObject("Content");

                //parse {"ServiceResponse"}
                JSONObject serviceRespObj = contentObj.getJSONObject("ServiceResponse");

                //parse {"ServiceRespHeader"}
                JSONObject serviceRespHeaderObj = serviceRespObj.getJSONObject("ServiceRespHeader");
                globalErrorID = serviceRespHeaderObj.getString("GlobalErrorID");
                errorText = serviceRespHeaderObj.getString("ErrorText");
                Object errorDetails = serviceRespHeaderObj.get("ErrorDetails");

                if (globalErrorID.equals("010041")) {
                    System.out.println(errorText);
                    System.out.println(errorDetails);
                    System.out.println("OTp expired, new OTP will be sent");
                } else if (!globalErrorID.equals("010000")) {
                    System.out.println(errorText);
                    System.out.println(errorDetails);
                } else {
                    System.out.println("Status = Done");
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(ScoringServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static String getBody(HttpServletRequest request) throws IOException {

        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            } else {
                stringBuilder.append("");
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }

        body = stringBuilder.toString();
        return body;
    }

    public static org.json.simple.JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (org.json.simple.JSONObject) parser.parse(jsonString);
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
