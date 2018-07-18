/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.blockchain;

import java.net.*;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import org.json.simple.*;
import org.json.simple.parser.*;
/**
 *
 * @author Jordy
 */
public class BlockchainHandler {
    
    private static HttpURLConnection con;
    private static final String URL = "http://127.0.0.1:8545";
    
    
    public static void main(String[] args){
        
        
    }
    
    public static String sendPostRequest(JSONObject body) throws MalformedURLException,
            ProtocolException, IOException{
        byte[] postData = body.toString().getBytes(StandardCharsets.UTF_8); 
        try{
            URL myurl = new URL(URL);
            con = (HttpURLConnection) myurl.openConnection();
            
            con.setDoOutput(true);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            
            try(DataOutputStream wr = new DataOutputStream(con.getOutputStream())){
                wr.write(postData);
            }
            
            StringBuilder content;
            
            try(BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()))){
                
                String line;
                content = new StringBuilder();
                
                while((line = in.readLine()) != null){
                    content.append(line);
                    content.append(System.lineSeparator());
                }
            }
            
            System.out.println(content.toString());
            
            return content.toString();
        }finally{
            con.disconnect();
        }
    }
    
    public static JSONObject getJSONObject(String jsonString){
        JSONParser parser = new JSONParser();
        try{
            return (JSONObject) parser.parse(jsonString);
        }catch(ParseException e){
            System.out.println("Parse Exception Occured!");
        }
        return null;
    }
    
    public static ArrayList<String> getListOfAccounts(){
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_accounts");
        body.put("params", new JSONArray());
        body.put("id", 1);
        try{
            String result = sendPostRequest(body);
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
        }
        
        return null;
    }
}
