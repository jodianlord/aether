/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.aether.blockchain.BlockchainHandler;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author jordysamuel
 */
public class BlockchainVis extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        
        String resp = "";
        
        String method = request.getParameter("method");
        String publicKey = request.getParameter("publicKey");
        if(method.equals("getBalance")){
            resp = BlockchainHandler.getBalance(publicKey).toString();
        }else if(method.equals("deployContract")){
            try{               
                String body = getBody(request);
                JSONObject resultJSON = getJSONObject(body);
                String uuid = (String) resultJSON.get("uuid");
                String hash = (String) resultJSON.get("hash");
                
                resp = BlockchainHandler.deployContract(publicKey, uuid, hash);
            }catch(ParseException e){
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp = "Error: Parse Exception Ocurred";
            }
        }else if(method.equals("unlock")){
            if(BlockchainHandler.unlockAccount(publicKey, "password")){
                System.out.println("We unlocked it!");
                resp = "Account Successfully Unlocked!";
            }else{
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp = "Account was not unlocked";
            }
        }else if(method.equals("receipt")){
            String transactionHash = request.getParameter("transactionhash");
            resp = BlockchainHandler.getContractAddress(transactionHash);
        }else if(method.equals("hash")){
            String randomstring = request.getParameter("randomstring");
            resp = BlockchainHandler.keccak256hash(randomstring);
        }else if(method.equals("getBalance")){
            String publickey = request.getParameter("publickey");
            resp = BlockchainHandler.getBalance(publickey).toString();
        }
        
        
        
        System.out.println("sending response");
        
        JSONObject newJSON = new JSONObject();
        newJSON.put("result", resp);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println(newJSON.toJSONString());
        }
        
        response.setStatus(HttpServletResponse.SC_OK);
    }
    
    public static JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (JSONObject) parser.parse(jsonString);
    }
    
    public static String getBody(HttpServletRequest request) throws IOException {

        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            } else {
                stringBuilder.append("");
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }

        body = stringBuilder.toString();
        return body;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
