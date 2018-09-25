/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import com.aether.blockchain.BlockchainHandler;
import com.aether.util.Dreamfactory;
import com.aether.util.FileHandler;
import com.aether.util.SendEmailSSL;
import static com.aether.util.TWOFA.genRandomPin;
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
import java.io.BufferedWriter;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import org.json.simple.JSONArray;

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
        response.setContentType("application/zip");

        
        
        
        
        
        //2FA Starts here
        String apiServiceUrl = "http://tbankonline.com/SMUtBank_API/Gateway";

        try {

            // build header
            org.json.JSONObject jo = new org.json.JSONObject();
            jo.put("serviceName", "sendSMS");
            jo.put("userID", "S9445003I"); //Using Static tbank account need to change to valid t_bank account userID
            jo.put("PIN", "940412"); //
            jo.put("OTP", "999999"); //send message to declare mobileNumber
            org.json.JSONObject headerObj = new org.json.JSONObject();
            headerObj.put("Header", jo);
            String header = headerObj.toString();

            // build content
            jo = new org.json.JSONObject();
            jo.put("mobileNumber", "6581275524");  // this should be the agent's mobile number

            String OTP_Number = genRandomPin();

            jo.put("message", "Your OTP is " + OTP_Number);
            org.json.JSONObject contentObj = new org.json.JSONObject();
            contentObj.put("Content", jo);
            String content = contentObj.toString();

            // connect to API service
            HttpURLConnection urlConnection = (HttpURLConnection) new URL(apiServiceUrl).openConnection();
            urlConnection.setDoOutput(true);
            urlConnection.setRequestMethod("POST");

            // build request parameters
            String parameters
                    = "Header=" + header + "&"
                    + "Content=" + content;

            // send request
            BufferedWriter br = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
            br.write(parameters);
            br.close();

            // get response
            String resp = "";
            Scanner s = new Scanner(urlConnection.getInputStream());
            while (s.hasNextLine()) {
                resp += s.nextLine();
            }
            s.close();

            // get response object
            org.json.JSONObject responseObj = new org.json.JSONObject(resp);
            System.out.println(responseObj.toString(4)); // indent 4 spaces
            System.out.println();

            String OTPConfirmationNumber = request.getParameter("OTP_Number");
            if (!OTP_Number.equals(OTPConfirmationNumber)) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            } else {
                response.setStatus(HttpServletResponse.SC_OK);
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        }

        String body = getBody(request);
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
            //resultJSON.remove("userdata");

            String jsonPath = path + randomUUIDString + ".json";
            File jsonFile = new File(jsonPath);
            if (!jsonFile.exists()) {
                jsonFile.createNewFile();
            }
            byte[] contentBytes = resultJSON.toString().getBytes();
            FileOutputStream fileOut = new FileOutputStream(jsonFile);
            fileOut.write(contentBytes);
            fileOut.flush();
            fileOut.close();
            //Charset charset = Charset.forName("UTF-8");
            //FileUtils.writeStringToFile(jsonFile, resultJSON.toString(), charset, false);

            String picture = (String) resultJSON.get("picture");
            String pictureType = picture.substring((picture.indexOf('/') + 1), picture.indexOf(';')).toUpperCase();
            String picturePath = path + randomUUIDString + "_picture." + pictureType;
            File pictureFile = new File(picturePath);
            FileOutputStream pictureOut = new FileOutputStream(pictureFile);
            BufferedImage image = decodeToImage(picture.substring((picture.indexOf(',') + 1), picture.length()));
            ImageIO.write(image, pictureType, pictureOut);

            String userdata = (String) resultJSON.get("userdata");
            String userdataType = userdata.substring((userdata.indexOf('/') + 1), userdata.indexOf(';')).toUpperCase();
            String userdataPath = path + randomUUIDString + "_userdata." + userdataType;
            File userdataFile = new File(userdataPath);
            FileOutputStream userdataFileOut = new FileOutputStream(userdataFile);
            BufferedImage userImage = decodeToImage(userdata.substring((userdata.indexOf(',') + 1), userdata.length()));
            ImageIO.write(userImage, userdataType, userdataFileOut);

            List<String> fileNames = new ArrayList<String>();
            fileNames.add(jsonPath);
            fileNames.add(picturePath);
            fileNames.add(userdataPath);

            File finalZip = Zipper.zipFiles(fileNames, path, randomUUIDString);
            String hash = BlockchainHandler.keccak256hash(finalZip);
            String userID = (String) request.getSession().getAttribute("userid");

            HashMap<String, String> filterKey = new HashMap<String, String>();
            filterKey.put("userid", userID);

            JSONArray userJSON = Dreamfactory.getRecordsFromTable("user", filterKey);
            JSONObject record = (JSONObject) userJSON.get(0);
            String publicKey = (String) record.get("publickey");
            System.out.println("Bad Public Key: " + publicKey);
            publicKey = publicKey.replace("\u0000", "");
            System.out.println("Public Key: " + publicKey);
            if (BlockchainHandler.unlockAccount(publicKey, "password")) {
                String transactionHash = BlockchainHandler.deployContract(publicKey, randomUUIDString, hash);
                JSONObject toCustomer = new JSONObject();
                toCustomer.put("transactionHash", transactionHash);
                toCustomer.put("uuid", randomUUIDString);
                toCustomer.put("hash", hash);
                String finalJSON = toCustomer.toString();
                try (FileOutputStream outputStream = new FileOutputStream(request.getServletContext().getRealPath("/") + "UDI_" + fullname + ".bin")) {
                    byte[] strToBytes = finalJSON.getBytes();
                    outputStream.write(strToBytes);
                    SendEmailSSL.generateAndSendEmail(email, new File(request.getServletContext().getRealPath("/") + "UDI_" + fullname + ".bin"));
                } catch (IOException e) {

                } catch (AddressException e) {

                } catch (MessagingException e) {

                }
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

            FileHandler.uploadFile(finalZip);

            pictureOut.close();
            userdataFileOut.close();
            if (jsonFile.delete() && pictureFile.delete() && userdataFile.delete()) {
                System.out.println("File deleted successfully");
            } else {
                System.out.println("Files not deleted!");
            }

            try (OutputStream out = response.getOutputStream()) {
                Path zipPath = finalZip.toPath();
                Files.copy(zipPath, out);
                out.flush();
            } catch (IOException e) {

            }

            response.setStatus(HttpServletResponse.SC_OK);

            //ImageIO.write(image, pictureType, response.getOutputStream());
        } catch (ParseException e) {

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
