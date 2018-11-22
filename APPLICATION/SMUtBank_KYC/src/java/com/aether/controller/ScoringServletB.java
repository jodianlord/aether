/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import com.aether.dao.QuestionDAO;
import com.aether.util.ConnectionManager;
import com.aether.util.TbankAPI;
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
import java.util.Properties;
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
@WebServlet(name = "ScoringServletB", urlPatterns = {"/ScoringServletB"})
public class ScoringServletB extends HttpServlet {

    private static final String PROPS_FILENAME = "connection.properties";
    public static String gameID;

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
    static {
        readGameID();
    }

    private static void readGameID() {
        InputStream is = null;
        try {
            // Retrieve properties from connection.properties via the CLASSPATH
            // WEB-INF/classes is on the CLASSPATH
            is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);

            // load database connection details
            String conngameID = props.getProperty("gameID");
            gameID = conngameID;

        } catch (Exception ex) {
            // unable to load properties file
            String message = "Unable to load '" + PROPS_FILENAME + "'.";

            System.out.println(message);
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
            throw new RuntimeException(message, ex);
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException ex) {
                    Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING, "Unable to close connection.properties", ex);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        response.setContentType("application/json");

        String apiServiceUrl = TbankAPI.tbankURL;
        String body = getBody(request);
        boolean verbose = true;

        try (PrintWriter out = response.getWriter()) {
            org.json.simple.JSONObject resultJSON = new org.json.simple.JSONObject();
            boolean result = false;
            org.json.simple.JSONObject jsonContent = getJSONObject(body);

            //System.out.println(jsonContent);
            int timeOne = Integer.parseInt(jsonContent.get("pageNo1").toString());
            int timeTwo = Integer.parseInt(jsonContent.get("pageNo2").toString());
            int timeThree = Integer.parseInt(jsonContent.get("pageNo3").toString());
            int scoreA = 1000 + (60-timeOne);
            int scoreB = 1000 + (60-timeTwo);
            int scoreC = 1000 + (60-timeThree);
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
                System.out.print("qqqqq" + qAnswerOne);

                Object c1 = jsonContent.get("questionID-" + qIDOne);
                if (c1 != null) {
                    String correctAns = jsonContent.get("questionID-" + qIDOne).toString();
                    if (qAnswerOne.equals(correctAns)) {
                        scoreA += 100;
                    }
                } else {
                    scoreA = 0;
                }

            }
            getQnsAns = qnsDAO.getQuestionAnswer(qIDTwo);
            if (getQnsAns != null) {
                qAnswerTwo = getQnsAns.getString("answer");
                Object c1 = jsonContent.get("questionID-" + qIDTwo);
                if (c1 != null) {
                    String correctAns = jsonContent.get("questionID-" + qIDTwo).toString();
                    if (qAnswerTwo.equals(correctAns)) {
                        scoreB += 100;
                    }
                } else {
                    scoreB = 0;
                }
            }
            getQnsAns = qnsDAO.getQuestionAnswer(qIDThree);
            if (getQnsAns != null) {
                qAnswerThree = getQnsAns.getString("answer");
                Object c1 = jsonContent.get("questionID-" + qIDThree);
                if (c1 != null) {
                    String correctAns = jsonContent.get("questionID-" + qIDThree).toString();
                    if (qAnswerThree.equals(correctAns)) {
                        scoreC += 100;
                    }
                } else {
                    scoreC = 0;
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
            String userID = jsonContent.get("userID").toString(); //pass in from front end //jsonContent.get("userID").toString();
            String PIN = "";
            String OTP = "";
            String gameID = ScoringServletB.gameID;
            System.out.println("" + ScoringServletB.gameID);
            String questionID = "";
            String scoreString = "";
            String mode = "Default";
            String groupID = jsonContent.get("groupID").toString();

            JSONObject jo = new JSONObject();
            jo.put("serviceName", serviceName);
            jo.put("userID", userID); //userid = groupid
            System.out.println("GID = " + groupID); //
            jo.put("PIN", PIN);
            jo.put("OTP", OTP);
            JSONObject headerObj = new JSONObject();
            headerObj.put("Header", jo);
            String header = headerObj.toString();

            for (int i = 1; i <= 3; i++) {

                //build content
                jo = new JSONObject();
                jo.put("gameID", gameID);
                jo.put("questionID", qObj.get("" + i));
                jo.put("score", scoreObj.get("" + i));
                jo.put("groupID", groupID); //
                //test
                System.out.println(qObj.get("" + i).toString() + ">>>>>>" + scoreObj.get("" + i).toString());
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
