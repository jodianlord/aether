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
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import org.json.simple.*;
import org.json.simple.parser.*;
import org.bouncycastle.jcajce.provider.digest.Keccak;
import java.security.MessageDigest;



/**
 *
 * @author Jordy
 */
public class BlockchainHandler {

    private static HttpURLConnection con;
    private static final String URL = "http://vm.jordysamuel.com:30301/Blockchain/";
    private static final BigInteger ETHTOWEI = new BigInteger("1000000000000000000");

    public static JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (JSONObject) parser.parse(jsonString);
    }
    
    public static String keccak256hash(String toHash){
        Keccak.Digest256 digest256 = new Keccak.Digest256();
        digest256.update(toHash.getBytes());

        return hashToString(digest256);
    }
    
    public static String hashToString(MessageDigest hash) {
        return hashToString(hash.digest());
    }
    
    public static String hashToString(byte[] hash) {
        StringBuffer buff = new StringBuffer();

        for (byte b : hash) {
            buff.append(String.format("%02x", b & 0xFF));
        }

        return buff.toString();
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
            String result = RESTHandler.sendPostRequest(URL, body, "bc.key");
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
            String result = RESTHandler.sendPostRequest(URL, body, "bc.key");
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
    
    public static boolean unlockAccount(String publicKey, String password){
        JSONObject body = new JSONObject();
        body.put("method", "unlockAccount");
        JSONObject param = new JSONObject();
        param.put("publicKey", publicKey);
        param.put("password", password);
        body.put("param", param);
        
        try {
            String result = RESTHandler.sendPostRequest(URL, body, "bc.key");
            System.out.println(result);
            JSONObject jsonResult = getJSONObject(result);
            String status = (String) jsonResult.get("result");
            return status.equals("true");
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        } catch (ParseException e) {
            System.out.println("Parse Exception!");
        }

        return false;
    }

    public static ArrayList<String> getListOfAccounts() {
        String requestURL = URL + "?method=getListOfAccounts";
        try {
            String result = RESTHandler.sendGetRequest(requestURL, "bc.key");
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

    public static BigInteger getBalance(String account) {
        String requestURL = URL + "?method=getBalance&publickey=" + account;
        try {
            String result = RESTHandler.sendGetRequest(requestURL, "bc.key");
            JSONObject jsonResult = getJSONObject(result);
            String hex = (String) jsonResult.get("result");
            BigInteger balance = new BigInteger(hex.substring(2, hex.length()), 16);
            return balance;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        } catch (ParseException e) {
            System.out.println("Parse Excepion!");
        }
        return new BigInteger("0");
    }
    
    public static void main(String[] args){
        String hex = "double(int256)";
        System.out.println(keccak256hash(hex));
    }
    
    
    public static BigInteger convertToEth(BigInteger balance){
        return balance.divide(ETHTOWEI);
    }
}
