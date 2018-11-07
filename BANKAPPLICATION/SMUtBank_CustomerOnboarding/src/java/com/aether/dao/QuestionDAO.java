/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.dao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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
import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Yuefeng
 */
public class QuestionDAO {

    String apiServiceUrl = "http://tbankonline.com/SMUtBank_API/Gateway";
    
    public JSONArray getSetA(){
        JSONArray qnsArray = new JSONArray();
        JSONObject firstQns = getQuestion("11");
        JSONObject secQns = getQuestion("11");
        JSONObject thirdQns = getQuestion("11");
        qnsArray.add(firstQns);
        qnsArray.add(secQns);
        qnsArray.add(thirdQns);
        //qnsArray.put(firstQns);
        
        return qnsArray;
    }
    
    public JSONArray getSetB(){
        JSONArray qnsArray = new JSONArray();
        JSONObject firstQns = getQuestion("11");
        JSONObject secQns = getQuestion("11");
        JSONObject thirdQns = getQuestion("11");
        qnsArray.add(firstQns);
        qnsArray.add(secQns);
        qnsArray.add(thirdQns);
        return qnsArray;
    }
    

    public JSONObject getQuestion(String qnsID) {
        try {

            boolean verbose = true;
            String serviceRespTag = "Get_Game_Question_ReadResponse";
            String globalErrorID;
            String errorText;
            Object errorDetails;
            String category;
            String question;
            String choices;
            String serviceName = "getGameQuestion";
            String userID = "";
            String PIN = "";
            String OTP = "";
            String questionID = qnsID;
            //build header

            JSONObject jo = new JSONObject();
            jo.put("serviceName", serviceName);
            jo.put("userID", userID);
            jo.put("PIN", PIN);
            jo.put("OTP", OTP);

            JSONObject headerObj = new JSONObject();
            headerObj.put("Header", jo);
            String header = headerObj.toString();

            //build content
            jo = new JSONObject();
            jo.put("questionID", questionID);
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
            String response = "";
            Scanner s = new Scanner(urlConnection.getInputStream());
            
            while (s.hasNextLine()) {
                response += s.nextLine();
            }
            s.close();

            //get reponse object
            boolean apiError;
            JSONObject responseObj = new JSONObject();
            responseObj = new JSONObject(response);
            if (verbose) {
                System.out.println(responseObj.toString(4));
                System.out.println();
            }
            
            //parse {"Content"}
            contentObj = responseObj.getJSONObject("Content");
            //parse {"ServiceResponse"}
            JSONObject serviceRespObj = contentObj.getJSONObject("ServiceResponse");
            //parse {"ServiceRespHeader"}
            JSONObject serviceRespHeaderObj = serviceRespObj.getJSONObject("ServiceRespHeader");
            globalErrorID = serviceRespHeaderObj.getString("GlobalErrorID");
            errorText = serviceRespHeaderObj.getString("ErrorText");
            errorDetails = serviceRespHeaderObj.get("ErrorDetails");

            if (!globalErrorID.equals("010000")) {

                System.out.println(errorText);
                
                System.out.println(errorDetails.toString());
                return null;

            } else {

                JSONObject qdoj = new JSONObject();
                qdoj = serviceRespObj.getJSONObject("QuestionDetails");
                          
                return qdoj;
                /*
                category = qdoj.getString("category");
                question = qdoj.getString("question");
                choices = qdoj.getString("choices");

                System.out.println("Category : " + category);

                System.out.println(question);

                String labels[] = new String[5];

                labels[0] = "a) ";

                labels[1] = "b) ";

                labels[2] = "c) ";

                labels[3] = "d) ";

                labels[4] = "e) ";

                String[] options = choices.split("&&");

                //Array labels = ["a) ";"b) ";"c) ";"d) ";"e) "];
                for (int i = 0; i < options.length; i++) {
                    String part = options[i];
                    System.out.println(labels[i] + part);
                }
                */
            }
            
        } catch (IOException | JSONException e) {
            return null;
        }

        
    }

}
