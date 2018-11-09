/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import com.aether.blockchain.BlockchainHandler;
import com.aether.util.JDBCHandler;
import com.aether.util.RESTHandler;
import static com.aether.util.RESTHandler.sendMultipartPost;
import com.aether.util.SendEmailSSL;
import com.aether.util.TBankEmail;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import sun.misc.BASE64Decoder;
import java.util.UUID;
import org.apache.commons.io.FileUtils;
import com.aether.util.Zipper;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import org.bouncycastle.util.encoders.Base64Encoder;
import org.json.simple.JSONArray;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Jordy
 */
public class IdentityServlet extends HttpServlet {

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
        
        //generate random UUID for this user
        UUID uuid = UUID.randomUUID();
        String randomUUIDString = uuid.toString();
        String path = request.getServletContext().getRealPath("/");
        try {
            JSONObject resultJSON = getJSONObject(body);
            String password = (String) resultJSON.get("password");
            String email = (String) resultJSON.get("email");
            String fullname = (String) resultJSON.get("fullname");
            System.out.println(password);
            resultJSON.remove("password");
            //resultJSON.remove("picture");
            
            
            //get png file of the person's face and get the encoding
            String picture = (String) resultJSON.get("picture");
            String pictureType = picture.substring((picture.indexOf('/') + 1), picture.indexOf(';')).toUpperCase();
            String picturePath = path + randomUUIDString + "_picture." + pictureType;
            File pictureFile = new File(picturePath);
            FileOutputStream pictureOut = new FileOutputStream(pictureFile);
            BufferedImage image = decodeToImage(picture.substring((picture.indexOf(',') + 1), picture.length()));
            ImageIO.write(image, pictureType, pictureOut);
            
            HashMap<String, File> encodeMap = new HashMap<String, File>();
            encodeMap.put("image", pictureFile);
            
            
            String encodedPicture = sendMultipartPost(RESTHandler.facialURL + "getencoding", encodeMap);
            JSONObject encodeObject = getJSONObject(encodedPicture);
            
            //resultJSON.put("encoding", encodeObject.get("encoding"));
            resultJSON.put("uuid", uuid.toString());
            
            String resultString = resultJSON.toJSONString();
            String faceString = encodeObject.toJSONString();
            
            String hash = BlockchainHandler.keccak256hash(resultString + faceString);
            String userID = (String) request.getSession().getAttribute("userid");

            HashMap<String, String> filterKey = new HashMap<String, String>();
            filterKey.put("userid", userID);

            JSONArray userJSON;
            try {
                userJSON = JDBCHandler.getUserRecordsFromTable("user", filterKey);
            } catch (SQLException ex) {
                Logger.getLogger(IdentityServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }
            JSONObject record = (JSONObject) userJSON.get(0);
            String publicKey = (String) record.get("publickey");
            System.out.println("Bad Public Key: " + publicKey);
            publicKey = publicKey.replace("\u0000", "");
            System.out.println("Public Key: " + publicKey);
            String transactionHash;
            if(BlockchainHandler.unlockAccount(publicKey, password)){
                transactionHash = BlockchainHandler.deployContract(publicKey, randomUUIDString, hash);
                System.out.println(transactionHash);
                JSONObject toCustomer = new JSONObject();
                toCustomer.put("transactionHash", transactionHash);
                toCustomer.put("uuid", randomUUIDString);
                toCustomer.put("hash", hash);
                String finalJSON = toCustomer.toString();
                try(FileOutputStream outputStream = new FileOutputStream(request.getServletContext().getRealPath("/") + "UDI_" + fullname + ".bin")){
                    byte[] strToBytes = finalJSON.getBytes();
                    outputStream.write(strToBytes);
                    BASE64Encoder encoder = new BASE64Encoder();
                    String finalBytes = encoder.encode(finalJSON.getBytes());
                    System.out.println("finalbytes: " + finalBytes);
                    TBankEmail.sendEmail(email, "Your Onboarding Details", finalJSON);
                    //SendEmailSSL.generateAndSendEmail(email, new File(request.getServletContext().getRealPath("/") + "UDI_" + fullname + ".bin"));
                }catch(IOException e){
                    
                }
            }else{
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }
            resultJSON.remove("picture");
            HashMap<String, String> createMap = new HashMap<String, String>();
            createMap.put("transaction_address", transactionHash);
            createMap.put("uuid", uuid.toString());
            createMap.put("facial_encoding", faceString);
            createMap.put("json_data", resultString);
            createMap.put("integrity_hash", hash);
            
            JDBCHandler.createRecords("contract", createMap);
            pictureFile.delete();

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (ParseException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } catch (SQLException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Logger.getLogger(IdentityServlet.class.getName()).log(Level.SEVERE, null, ex);
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

    public static BufferedImage decodeToImage(String imageString) {
        BufferedImage image = null;
        byte[] imageByte;
        try {
            BASE64Decoder decoder = new BASE64Decoder();
            imageByte = decoder.decodeBuffer(imageString);
            ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
            image = ImageIO.read(bis);
            bis.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return image;
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
