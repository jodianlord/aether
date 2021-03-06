/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import com.aether.blockchain.BlockchainHandler;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Jordy
 */
public class VerifyUser extends HttpServlet {

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
        String body = getBody(request);
        System.out.println("body: " + body);
        try {
            JSONObject bodyJSON = getJSONObject(body);
            File zipFile = FileHandler.getFile(bodyJSON.get("uuid") + ".zip", request.getServletContext().getRealPath("/"));
            String hash = BlockchainHandler.keccak256hash(zipFile);
            String binHash = (String) bodyJSON.get("hash");
            String contractAddress = BlockchainHandler.getContractAddress((String) bodyJSON.get("transactionHash"));
            String blockchainHash = BlockchainHandler.getHash(contractAddress);
            System.out.println(hash);
            System.out.println(binHash);
            System.out.println(blockchainHash);
            zipFile.delete();
            if (hash.equals(blockchainHash) && binHash.equals(blockchainHash)) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                try (PrintWriter out = response.getWriter()) {
                    /* TODO output your page here. You may use following sample code. */
                    JSONObject json = new JSONObject();
                    json.put("result", "fail");
                    out.println(json.toString());
                    return;
                }
            }
            
        } catch (ParseException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            JSONObject json = new JSONObject();
            json.put("result", "success");
            out.println(json.toString());
        }
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

    public static JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (JSONObject) parser.parse(jsonString);
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
