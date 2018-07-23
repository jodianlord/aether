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
    private static final String URL = "http://vm.jordysamuel.com:30301/Blockchain/?sendRaw=true";
    private static final double ETHTOWEI = 1000000000000000000.0;
    
    public static double ethToWei(double eth){
        return eth * ETHTOWEI;
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
    
    public static JSONObject getJSONObject(String jsonString) throws ParseException{
        JSONParser parser = new JSONParser();
        return (JSONObject) parser.parse(jsonString);
    }
    
    public static String sendTransaction(String from, String to, double value){
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_sendTransaction");
        
        JSONObject params = new JSONObject();
        params.put("from", from);
        params.put("to", to);
        params.put("value", ethToWei(value));
        JSONArray parameters = new JSONArray();
        parameters.add(params);
        body.put("params", params);
        
        try{
            String result = sendPostRequest(body);
            JSONObject jsonResult = getJSONObject(result);
            String transactionHash = (String) jsonResult.get("result");
            return transactionHash;
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
        }catch(ParseException e){
            System.out.println("Parse Exception!");
        }
        
        return null;
    }
    
    public static String createAccount(String password){
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "personal_newAccount");
        JSONArray params = new JSONArray();
        params.add(password);
        body.put("params", params);
        body.put("id", 1);
        System.out.println(body.toString());
        try{
            String result = sendPostRequest(body);
            System.out.println(result);
            JSONObject jsonResult = getJSONObject(result);
            String transactionHash = (String) jsonResult.get("result");
            return transactionHash;
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
        }catch(ParseException e){
            System.out.println("Parse Exception!");
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
            JSONObject jsonResult = getJSONObject(result);
            
            ArrayList accountList = (ArrayList) jsonResult.get("result");
            return accountList;
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
        }catch(ParseException e){
            System.out.println("Parse Excepion!");
        }
        
        return null;
    }
}
