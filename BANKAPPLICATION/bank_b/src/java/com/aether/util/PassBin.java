/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import com.aether.blockchain.BlockchainHandler;
import com.aether.util.Unzipper;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Chuanyi
 */
@WebServlet(name = "PassBin", urlPatterns = {"/PassBin"})
public class PassBin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws org.json.simple.parser.ParseException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json");
        try {
            String body = getBody(request);
            JSONObject bodyJSON = getJSONObject(body);
            String binfile = (String) bodyJSON.get("binfile");
            String base = binfile.substring(binfile.indexOf(',') + 1, binfile.length());
            byte[] binBytes = base.getBytes();
            byte[] decoded = Base64.decodeBase64(binBytes);
            System.out.println(new String(decoded));
            String bin = new String(decoded);
            JSONObject binJSON = getJSONObject(bin);
            String uuid = (String) binJSON.get("uuid");
            File zipFile = FileHandler.getFile(uuid + ".zip", request.getServletContext().getRealPath("/"));
            ArrayList<File> unzipped = Unzipper.unzip(zipFile.getPath(), request.getServletContext().getRealPath("/"));
            for (File f : unzipped) {
                System.out.println(f.getName());
                if (f.getName().indexOf(".json") != -1) {
                    try (PrintWriter out = response.getWriter()) {
                        byte[] encoded = Files.readAllBytes(Paths.get(f.getPath()));
                        String print = new String(encoded);
                        System.out.println(print);
                        out.println(print);
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                }
                f.delete();
            }
            zipFile.delete();
        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        } catch (ParseException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
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
