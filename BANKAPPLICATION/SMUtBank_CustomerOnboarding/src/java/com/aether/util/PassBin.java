/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import com.aether.blockchain.BlockchainHandler;
import static com.aether.controller.IdentityServlet.decodeToImage;
import com.aether.util.Unzipper;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.codec.binary.Base64;
import org.json.simple.JSONArray;
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
            System.out.println("BITCH" + bodyJSON.toJSONString());

            //retrieve binfile and verification image
            String binfile = (String) bodyJSON.get("binfile");
            System.out.println("THIS IS THE BINFILE");
            System.out.println(binfile);
            System.out.println(binfile.indexOf(','));
            //String base = binfile.substring(binfile.indexOf(',') + 1, binfile.length());
            //byte[] binBytes = base.getBytes();
            //byte[] decoded = Base64.decodeBase64(binBytes);
            //System.out.println("decoded JSON" + new String(decoded));
            String bin = binfile;
            System.out.println(bin);
            JSONObject binJSON = getJSONObject(bin);
            String uuid = (String) binJSON.get("uuid");
            String hash = (String) binJSON.get("hash");

            //retrieve face encoding from the database
            System.out.println("get database shit");
            Map<String, String> criteria = new HashMap<String, String>();
            criteria.put("uuid", uuid);

            JSONObject faceEncoding = null;
            JSONObject baseJSON = null;
            String transactionAddress = null;
            try {
                JSONArray data = JDBCHandler.getContracts("contract", criteria);
                if (data == null || data.isEmpty()) {
                    System.out.println("data is empyt!");
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    return;
                }
                JSONObject dataObj = (JSONObject) data.get(0);
                String baseJSONString = (String) dataObj.get("json_data");
                baseJSON = getJSONObject(baseJSONString);
                String faceEncodingString = (String) dataObj.get("facial_encoding");
                faceEncoding = getJSONObject(faceEncodingString);
                System.out.println("JSON String");
                System.out.println(baseJSON.toJSONString());
                System.out.println("Face Encoding");
                System.out.println(faceEncoding.toJSONString());
                transactionAddress = (String) dataObj.get("transaction_address");
                if (faceEncoding == null || baseJSON == null) {
                    System.out.println("something is null!");
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    return;
                }
                String generatedHash = BlockchainHandler.keccak256hash(baseJSON.toJSONString() + faceEncoding.toJSONString());
                String dataHash = (String) dataObj.get("integrity_hash");
                System.out.println("Generated Hash: " + generatedHash);
                System.out.println("bin Hash: " + hash);
                System.out.println("Database Hash: " + dataHash);
                if (!(generatedHash.equals(dataHash) && generatedHash.equals(hash))) {
                    System.out.println("hash is bad!");
                    try(PrintWriter out = response.getWriter()){
                        JSONObject outJSON = new JSONObject();
                        outJSON.put("status", "Error");
                        out.println(outJSON.toString());
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                    
                    return;
                }
            } catch (SQLException ex) {
                Logger.getLogger(PassBin.class.getName()).log(Level.SEVERE, null, ex);
            }

            //perform facial recognition on the verification picture
            String picture = (String) bodyJSON.get("verificationfile");
            System.out.println("THIS IS YOUR FACE" + picture);
            String pictureType = picture.substring((picture.indexOf('/') + 1), picture.indexOf(';')).toUpperCase();
            String picturePath = request.getServletContext().getRealPath("/") + uuid + "_verification." + pictureType;
            File pictureFile = new File(picturePath);
            FileOutputStream pictureOut = new FileOutputStream(pictureFile);
            BufferedImage image = decodeToImage(picture.substring((picture.indexOf(',') + 1), picture.length()));
            ImageIO.write(image, pictureType, pictureOut);

            Map<String, File> dataMap = new HashMap<String, File>();
            dataMap.put("image", pictureFile);

            String verificationEncodingString = RESTHandler.sendMultipartPost(RESTHandler.facialURL + "getencoding", dataMap);
            JSONObject verificationEncoding = getJSONObject(verificationEncodingString);

            JSONObject compareImages = new JSONObject();
            compareImages.put("first_encoding", faceEncoding.get("encoding"));
            compareImages.put("second_encoding", verificationEncoding.get("encoding"));

            String postResult = RESTHandler.sendPostRequest(RESTHandler.facialURL + "compareimages", compareImages, null);

            JSONObject postJSON = getJSONObject(postResult);

            if (!postJSON.get("match").equals("true")) {
                try(PrintWriter out = response.getWriter()){
                    JSONObject outJSON = new JSONObject();
                    outJSON.put("status", "Do Not Match");
                    out.println(outJSON.toString());
                    response.setStatus(HttpServletResponse.SC_OK);
                }
                return;
            }

            baseJSON.put("uuid", uuid);
            baseJSON.put("transactionHash", transactionAddress);
            baseJSON.put("hash", hash);

            try (PrintWriter out = response.getWriter()) {
                out.println(baseJSON.toString());
                response.setStatus(HttpServletResponse.SC_OK);
            }
            pictureFile.delete();
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
