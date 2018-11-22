/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Random;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet(name = "TWOFA", urlPatterns = {"/TWOFA"})
public class TWOFA extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public static String genRandomPin() {
        String randomPin = "";
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            //Math.random(0,10);
            randomPin = randomPin + (int) Math.floor(random.nextInt(10));
        }
        return randomPin;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");

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
        response.setContentType("text/plain;charset=UTF-8");
        
        String apiServiceUrl = TbankAPI.tbankURL;

        try {

            // build header
            JSONObject jo = new JSONObject();
            jo.put("serviceName", "sendSMS");
            jo.put("userID", "S9445003I"); //Using Static tbank account need to change to valid t_bank account userID
            jo.put("PIN", "940412"); //
            jo.put("OTP", "999999"); //send message to declare mobileNumber
            JSONObject headerObj = new JSONObject();
            headerObj.put("Header", jo);
            String header = headerObj.toString();

            // build content
            String mobileNumber = request.getParameter("mobileNumber");
            jo = new JSONObject();
            jo.put("mobileNumber", mobileNumber);  // this should be the agent's mobile number 6581275524

            String OTP_Number = genRandomPin();

            jo.put("message", "Your OTP is " + OTP_Number);
            JSONObject contentObj = new JSONObject();
            contentObj.put("Content", jo);
            String content = contentObj.toString();

            // connect to API service
            HttpURLConnection urlConnection = (HttpURLConnection) new URL(apiServiceUrl).openConnection();
            urlConnection.setDoOutput(true);
            urlConnection.setRequestMethod("POST");

            // build request parameters
            String parameters
                    = "Header=" + header + "&"
                    + "Content=" + content;

            // send request
            BufferedWriter br = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
            br.write(parameters);
            br.close();

            // get response
            String resp = "";
            Scanner s = new Scanner(urlConnection.getInputStream());
            while (s.hasNextLine()) {
                resp += s.nextLine();
            }
            s.close();

            // get response object
            JSONObject responseObj = new JSONObject(resp);
            System.out.println(responseObj.toString(4)); // indent 4 spaces
            System.out.println();

            try (PrintWriter out = response.getWriter()) {
                System.out.println(OTP_Number);
                out.print(OTP_Number);
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);

        }
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
