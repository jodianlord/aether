/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.blockchain;

import com.aether.util.RESTHandler;
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
    private static final String URL = "http://vm.jordysamuel.com:30301/Blockchain/";
    private static final double ETHTOWEI = 1000000000000000000.0;

    public static double ethToWei(double eth) {
        return eth * ETHTOWEI;
    }

    public static JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (JSONObject) parser.parse(jsonString);
    }

    public static String sendTransaction(String from, String to, double value) {
        JSONObject body = new JSONObject();
        body.put("method", "sendTransaction");

        JSONObject param = new JSONObject();
        param.put("from", from);
        param.put("to", to);
        param.put("value", value);
        body.put("param", param);

        try {
            String result = RESTHandler.sendPostRequest(URL, body);
            JSONObject jsonResult = getJSONObject(result);
            String transactionHash = (String) jsonResult.get("result");
            return transactionHash;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        } catch (ParseException e) {
            System.out.println("Parse Exception!");
        }

        return null;
    }

    public static String createAccount(String password) {
        JSONObject body = new JSONObject();
        body.put("method", "createAccount");
        JSONObject param = new JSONObject();
        param.put("password", password);
        body.put("param", param);
        try {
            String result = RESTHandler.sendPostRequest(URL, body);
            System.out.println(result);
            JSONObject jsonResult = getJSONObject(result);
            String transactionHash = (String) jsonResult.get("result");
            return transactionHash;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        } catch (ParseException e) {
            System.out.println("Parse Exception!");
        }

        return null;
    }

    public static ArrayList<String> getListOfAccounts() {
        String requestURL = URL + "?method=getListOfAccounts";
        try {
            String result = RESTHandler.sendGetRequest(requestURL);
            JSONObject jsonResult = getJSONObject(result);

            ArrayList accountList = (ArrayList) jsonResult.get("result");
            return accountList;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        } catch (ParseException e) {
            System.out.println("Parse Excepion!");
        }

        return null;
    }

    public static String getBalance(String account) {
        String requestURL = URL + "?method=getBalance&publickey=" + account;
        try {
            String result = RESTHandler.sendGetRequest(requestURL);
            JSONObject jsonResult = getJSONObject(result);
            String hex = (String) jsonResult.get("result");

            char[] chars = hex.toCharArray();

            StringBuffer hexdec = new StringBuffer();
            for (int i = 0; i < chars.length; i++) {
                hexdec.append(Integer.toHexString((int) chars[i]));
            }
            System.out.println(hexdec.toString());
            return hexdec.toString();
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        } catch (ParseException e) {
            System.out.println("Parse Excepion!");
        }

        return null;
    }
    
    public static double convertToEth(String dec){
        int balance = Integer.parseInt(dec);
        return balance / ETHTOWEI;
    }
}
