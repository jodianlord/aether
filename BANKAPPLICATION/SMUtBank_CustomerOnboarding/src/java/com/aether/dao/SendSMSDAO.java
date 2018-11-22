/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.dao;

import com.aether.util.TbankAPI;
import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import org.json.JSONObject;

/**
 *
 * @author Yuefeng
 */
public class SendSMSDAO {
    String apiServiceUrl = TbankAPI.tbankURL;
    public String sendMessage(String mobile, String message){
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
            
            jo = new JSONObject();
            jo.put("mobileNumber", mobile);  // this should be the agent's mobile number 6581275524

            //String OTP_Number = genRandomPin();

            jo.put("message", message);
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

           

        } catch (Exception e) {
            e.printStackTrace(System.out);

        }
        
        
        
        return "fk u";
    }
    
}
