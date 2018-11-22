/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

/**
 *
 * @author Chuanyi
 */
import java.io.*;

import java.util.*;

import java.net.*;

import org.json.*;



public class GetGameLeader

{

       public static void main(String args[])

       {        

               boolean verbose = true;

               

               //api url

               String apiServiceUrl = TbankAPI.tbankURL;

               

               String serviceRespTag = "Get_Game_Leaders_ReadResponse";

               String globalErrorID;

               String errorText;


               String score;

               String user_Id="";
               
               

               String serviceName = "getGameLeaders";

               String userID = "";

               String PIN = "";

               String OTP = "";

               String gameID = "1112"; //change accordingly

               String start = "2010-01-01 00:00:00";

               String end = "2019-01-01 23:59:59";

               String mode = "*";

               String byGroup = "true";

               try

               {

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

                       String parameters = "Header=" +header+ "&" + "Content=" +content;

                       

                       //sending of the request

                       BufferedWriter br = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));

                       br.write(parameters);

                       br.close();

                       

                       //getting the response

                       String response = "";

                       Scanner s = new Scanner(urlConnection.getInputStream());

                       while (s.hasNextLine())

                       {

                               response += s.nextLine();

                       }

                       s.close();

                       

                       //getting the response object

                       boolean apiError;

                       JSONObject responseObj = new JSONObject(response);

                       responseObj = new JSONObject(response);

                       

                       if (verbose)

                       {

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

                       Object errorDetails = serviceRespHeaderObj.get("ErrorDetails");

                       

                       if(!globalErrorID.equals("010000"))

                       {

                               System.out.println(errorText);

                               System.out.println(errorDetails);

                       }

                       else

                       {

                               JSONObject leaderObj = serviceRespObj.getJSONObject("LeaderDetails");

                               JSONObject leaderObj2 = leaderObj.getJSONObject("Leaders");

                               Object testObj = leaderObj2.get("Leader");
                                   System.out.println(">>>>>> " +leaderObj2.toString());

                               if (testObj instanceof JSONArray){
                                       JSONArray ldrObj = leaderObj2.getJSONArray("Leader");
                                       for (int i = 0; i < ldrObj.length(); i++)
                                       {

                                               JSONObject ldrobj = ldrObj.getJSONObject(i);

                                               score = ldrobj.getString("score");
                                               Object objUser =ldrobj.get("user_Id");
                                               if(objUser==null){
                                                   System.out.print("null la cb");
                                               }else{
                                                   user_Id = (String)objUser;
                                               }
                                       }
                                       
                                       System.out.println("jsonArray = " + ldrObj);

                               }

                               else if(testObj instanceof JSONObject)

                               {

                                       JSONObject ldrObj = leaderObj2.getJSONObject("Leader");

                                       score = ldrObj.getString("score");

                                       user_Id = ldrObj.getString("user_Id");

                                       

                                       System.out.println("score = " + score);

                                       System.out.println("user_id = " + user_Id);
                                       
                                       System.out.println("jsonObject = " + ldrObj);

                               }

                               else

                               {

                                       System.out.println("No record");

                               }

                       }        

               }

               catch(Exception e)

               {

                       e.printStackTrace(System.out);

               }

               

       }

}

