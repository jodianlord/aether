/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blockchain;

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
    private static final double ETHTOWEI = 1000000000000000000.0;
    
    
    public static void main(String[] args){
        //System.out.println(sendTransaction("0x9411c7c7E859d79FF025053137D32Db7431DDcB5", "0x7397fcf65152b25701a9F8640a2aEc6808209f61", 50.0).toString());
        //System.out.println(createAccount("password"));
    }
    
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
    
    public static String toHexValue(long toHex){
        return "0x" + Long.toHexString(toHex);
    }
    
    public static String sendTransaction(String from, String to, long value){
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_sendTransaction");
        
        JSONObject params = new JSONObject();
        params.put("from", from);
        params.put("to", to);
        params.put("value", toHexValue(value));
        JSONArray parameters = new JSONArray();
        parameters.add(params);
        body.put("params", parameters);
        body.put("id", 1);
        
        System.out.println("body: " + body.toJSONString());
        
        try{
            String result = sendPostRequest(body);
            return result;
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
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
            return result;
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
        }
        
        return null;
    }
    
    public static String unlockAccount(String publicKey, String password){
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "personal_unlockAccount");
        JSONArray params = new JSONArray();
        params.add(publicKey);
        params.add(password);
        body.put("params", params);
        body.put("id", 67);
        System.out.println(body.toString());
        try{
            String result = sendPostRequest(body);
            return result;
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
        }
        return null;
    }
    
    public static String getBalance(String publicKey){
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_getBalance");
        JSONArray params = new JSONArray();
        params.add(publicKey);
        params.add("latest");
        body.put("params", params);
        body.put("id", 1);
        try{
            String result = sendPostRequest(body);
            return result;            
        }catch(MalformedURLException e){
            System.out.println("Malformed URL!");
        }catch(ProtocolException f){
            System.out.println("Protocol Exception!");
        }catch(IOException e){
            System.out.println("IO Exception!");
        }
        return null;
    }
    
    public static String getListOfAccounts(){
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_accounts");
        body.put("params", new JSONArray());
        body.put("id", 1);
        try{
            String result = sendPostRequest(body);
            return result;            
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
