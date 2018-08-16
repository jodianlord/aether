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
import java.nio.file.Files;
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
    
    /**
     * Gets a JSONObject from a String, not to be directly called
     * @param jsonString
     * @return
     * @throws ParseException 
     */
    public static JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (JSONObject) parser.parse(jsonString);
    }
    
    /**
     * Hashes a String to a SHA3 String
     * @param toHash String to hash
     * @return 
     */
    public static String keccak256hash(String toHash) {
        Keccak.Digest256 digest256 = new Keccak.Digest256();
        digest256.update(toHash.getBytes());

        return hashToString(digest256);
    }

    /**
     * Hashes a File object to a SHA3 String
     * @param toHash File to hash
     * @return
     * @throws IOException 
     */
    public static String keccak256hash(File toHash) throws IOException {
        Keccak.Digest256 digest256 = new Keccak.Digest256();
        digest256.update(Files.readAllBytes(toHash.toPath()));
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
    
    /**
     * Sends a transaction from one address to another
     * @param from Public key of account to transfer from
     * @param to Public key of account to transfer to
     * @param value Value to transfer in wei
     * @return 
     */
    public static String sendTransaction(String from, String to, int value) {
        System.out.println("value: " + value);
        JSONObject body = new JSONObject();
        body.put("method", "sendTransaction");

        JSONObject param = new JSONObject();
        param.put("from", from);
        param.put("to", to);
        param.put("value", value);
        body.put("param", param);

        System.out.println(body.toJSONString());

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
            System.out.println("Parse Exception! Ahh!");
        }

        return null;
    }
    
    /**
     * Creates new account on the blockchain
     * @param password Password for the account
     * @return 
     */
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
    
    /**
     * Gets a contract address from a transaction hash
     * @param transactionHash Transaction Hash
     * @return 
     */
    public static String getContractAddress(String transactionHash){
        String requestURL = URL + "?method=getReceipt?transactionHash=" + transactionHash;
        try{
            String result = RESTHandler.sendGetRequest(requestURL, "bc.key");
            JSONObject resultJSON = getJSONObject(result);
            JSONObject resultExtract = (JSONObject) resultJSON.get("result");
            String contractAddress = (String) resultExtract.get("contractAddress");
            return contractAddress;
        }catch (MalformedURLException e) {
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
    
    /**
     * Gets hash encoded into the blockchain in a contract address
     * @param contractAddress contract address to retrieve the hash from
     * @return 
     */
    public static String getHash(String contractAddress){
        String requestURL = URL + "?method=getHash&contractAddress=" + contractAddress;
        try{
            String result = RESTHandler.sendGetRequest(requestURL, "bc.key");
            JSONObject resultJSON = getJSONObject(result);
            String hash = (String) resultJSON.get("result");
            return hash;
        }catch (MalformedURLException e) {
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
    
    /**
     * Gets uuid encoded into the blockchain in a contract address
     * @param contractAddress contract address to retrieve the uuid from
     * @return 
     */
    public static String getUUID(String contractAddress){
        String requestURL = URL + "?method=getUUID&contractAddress=" + contractAddress;
        try{
            String result = RESTHandler.sendGetRequest(requestURL, "bc.key");
            JSONObject resultJSON = getJSONObject(result);
            String hexUUID = (String) resultJSON.get("result");
            hexUUID = hexUUID.substring(128, hexUUID.length());
            hexUUID = hexUUID.substring(0, 72);
            return hexUUID;
        }catch (MalformedURLException e) {
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
    
    /**
     * Deploys the KYC Contract
     * @param publicKey Public Key of the account to deploy the contract from 
     * @param uuid UUID of the user detail to be encoded on the blockchain
     * @param hash Hash of the zip file to be encoded on the blockchain
     * @return 
     */
    public static String deployContract(String publicKey, String uuid, String hash){
        JSONObject body = new JSONObject();
        body.put("method", "unlockAccount");
        JSONObject param = new JSONObject();
        param.put("publicKey", publicKey);
        param.put("uuid", uuid);
        param.put("hash", hash);
        body.put("param", param);
        System.out.println(body.toString());
        try{
            String result = RESTHandler.sendPostRequest(URL, body, "bc.key");
            JSONObject jsonResult = getJSONObject(result);
            String transactionHash = (String) jsonResult.get("result");
            return transactionHash;
        }catch (MalformedURLException e) {
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
    
    /**
     * Unlocks account, necessary before performing any transaction or deployment
     * @param publicKey Public key of the account to be unlocked
     * @param password Password of the account to be unlocked
     * @return 
     */
    public static boolean unlockAccount(String publicKey, String password) {
        JSONObject body = new JSONObject();
        body.put("method", "unlockAccount");
        JSONObject param = new JSONObject();
        param.put("publicKey", publicKey);
        param.put("password", password);
        body.put("param", param);
        System.out.println(body.toString());
        try {
            String result = RESTHandler.sendPostRequest(URL, body, "bc.key");
            System.out.println("unlock: " + result);
            JSONObject jsonResult = getJSONObject(result);
            boolean status = (boolean) jsonResult.get("result");
            return status;
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
    
    /**
     * Gets an ArrayList of all accounts
     * @return 
     */
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
    
    /**
     * Gets the balance in wei of an account
     * @param account Public Key of the account to get the balance from
     * @return 
     */
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
    
    /**
     * Translates a String to its hex value
     * @param arg String to be hexed
     * @return 
     */
    public static String toHex(String arg) {
        return String.format("%x", new BigInteger(1, arg.getBytes()));
    }

    /**
     * Translates a decimal number to hex
     * @param toHex Integer to be hexed
     * @return 
     */
    public static String toHexValue(int toHex) {
        return Integer.toHexString(toHex);
    }

    public static void main(String[] args) {
        File f = new File("C:\\Users\\Jordy\\Documents\\aether\\APPLICATION\\Aether\\web\\0a4af52e-8c86-4009-882b-180464af09ff.zip");
        try{
            System.out.println(keccak256hash(f));
        }catch(IOException e){
            
        }
        
        System.out.println(toHex("0a4af52e-8c86-4009-882b-180464af09ff"));
        System.out.println(toHex("872365777ac706d254972a0aecaadd4b39ca05ce16c3f720d38587c502ed85c5"));
    }

    public static BigInteger convertToEth(BigInteger balance) {
        return balance.divide(ETHTOWEI);
    }
}
