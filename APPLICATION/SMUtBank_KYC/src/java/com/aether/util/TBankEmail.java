/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.Scanner;
import org.json.simple.JSONObject;

/**
 *
 * @author jordy
 */
public class TBankEmail {
    public static void main(String[] args){
        sendEmail("jordysamuel@gmail.com", "hi", "eyJ1dWlkIjoiOWZmZTUyODMtMzQwYy00MTIwLThkNjctNGQzZDNkOTEzOTI0IiwidHJhbnNhY3Rp\n" +
"b25IYXNoIjoiMHg1ZDIxNzAyNjBkNjc2NTM0MGIyOTUwZGVmMWM5YzFiODEwZDUxNDljMDU1MDQ0\n" +
"NDZkODMxYWQ1OWU4MjA0MWM1IiwiaGFzaCI6IjdhMDY4OWNkNmMxZjc5YjgzNDc5YWMwZDcxM2Nk\n" +
"ZmE1OTAwNmMxM2U5NGNjNDliMTdkYzIzYWFhYjJiYmI4MTUifQ==");
    }
    
    public static boolean sendEmail(String address, String subject, String contents){
        String apiServiceUrl = "http://tbankonline.com/SMUtBank_API/Gateway";
        
        String globalErrorID;
        String errorText;
        String errorDetails;
        
        String serviceName = "sendEmail";
        String userID = "S9445003I";
        String PIN = "940412";
        String OTP = "999999";
        String emailAddress = address;
        String emailSubject = subject;
        String emailBody = contents;
        
        try{
            JSONObject  jo = new JSONObject();
            jo.put("serviceName", serviceName);
            jo.put("userID", userID);
            jo.put("PIN", PIN);
            jo.put("OTP", OTP);
            JSONObject headerObj = new JSONObject();
            headerObj.put("Header", jo);
            String header = headerObj.toString();
            
            jo = new JSONObject();
            jo.put("emailAddress", emailAddress);
            jo.put("emailSubject", emailSubject);
            jo.put("emailBody", emailBody);
            JSONObject contentObj = new JSONObject();
            contentObj.put("Content", jo);
            String content = contentObj.toString();
            
            HttpURLConnection urlConnection = (HttpURLConnection) new URL(apiServiceUrl).openConnection();
            urlConnection.setDoOutput(true);
            urlConnection.setRequestMethod("POST");
            
            String parameters = "Header=" + header + "&" + "Content=" + content;
            
            BufferedWriter br = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
            br.write(parameters);
            br.close();
            
            String response = "";
            Scanner s = new Scanner(urlConnection.getInputStream());
            while(s.hasNextLine()){
                response += s.nextLine();
            }
            s.close();
            
            boolean apiError;
            return true;
            
        }catch(MalformedURLException e){
            e.printStackTrace();
            return false;
        }catch(ProtocolException e){
            e.printStackTrace();
            return false;
        }catch(IOException e){
            e.printStackTrace();
            return false;
        }
        
    }
}
