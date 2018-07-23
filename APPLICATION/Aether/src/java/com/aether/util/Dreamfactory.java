/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.net.*;
import java.util.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.*;
import org.json.simple.parser.*;

/**
 *
 * @author Jordy
 */
public class Dreamfactory {

    private static final String PROPS_FILENAME = "dreamfactory.properties";
    private static String requestURL;
    private static HttpURLConnection con;

    public static void main(String[] args) {
        HashMap<String, String> record = new HashMap<String, String>();
        record.put("userid", "asshole");
        record.put("password", "password");
        record.put("publickey", "dickshit");
        ArrayList<Map<String,String>> toFeed = new ArrayList<Map<String,String>>();
        toFeed.add(record);
        System.out.println(createRecords("user", toFeed).toString());
    }
    
    public static String deleteRecords(String table, String key, String value){
        return null;
    }
    
    public static String createRecords(String table, ArrayList<Map<String, String>> record){
        if(record == null || record.size() == 0){
            return null;
        }
        JSONObject body = new JSONObject();
        JSONArray resource = new JSONArray();
        for(Map<String, String> rec : record){
            JSONObject oneRecord = new JSONObject();
            Iterator keyIt = rec.entrySet().iterator();
            while(keyIt.hasNext()){
                Map.Entry pair = (Map.Entry) keyIt.next();
                String key = (String) pair.getKey();
                String value = (String) pair.getValue();
                oneRecord.put(key, value);
            }
            resource.add(oneRecord);
        }
        body.put("resource", resource);
        String function = "_table/" + table;
        readDreamfactoryProperties(function, null);
        try{
            return RESTHandler.sendPostRequest(requestURL, body);
        }catch(MalformedURLException e){
            e.printStackTrace();
        }catch(ProtocolException e){
            e.printStackTrace();
        }catch(IOException e){
            e.printStackTrace();
        }
        return null;
    }

    public static JSONArray getRecordsFromTable(String table, Map<String, String> filter) {
        String params = "";
        if (filter.size() != 0) {
            params += "filter=";
            Iterator keyIt = filter.entrySet().iterator();
            boolean hasPrevious = false;
            while (keyIt.hasNext()) {
                Map.Entry pair = (Map.Entry) keyIt.next();
                String key = (String) pair.getKey();
                String value = (String) pair.getValue();
                if (hasPrevious) {
                    params += "%3D";
                }
                params += key + "=" + value;
                hasPrevious = true;
            }
        }
        
        String function = "_table/" + table;
        readDreamfactoryProperties(function, params);
        String result;
        try {
            result = RESTHandler.sendGetRequest(requestURL);
        } catch (IOException e) {
            System.out.println("IO Exception!");
            return null;
        }
        JSONParser parser = new JSONParser();
        try {
            JSONObject records = (JSONObject) parser.parse(result);
            JSONArray resultJSON = (JSONArray) records.get("resource");
            return resultJSON;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static void readDreamfactoryProperties(String function, String params) {
        InputStream is = null;
        try {
            // Retrieve properties from connection.properties via the CLASSPATH
            // WEB-INF/classes is on the CLASSPATH
            is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);

            // load database connection details
            String host = props.getProperty("df.host");
            String key = props.getProperty("df.key");

            requestURL = host + function + "?api_key=" + key;
            if (params != null && params.length() != 0) {
                requestURL += "&" + params;
            }
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
}
