/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONObject;

/**
 *
 * @author jodia
 */
public class FileHandler {

    private static final String PROPS_FILENAME = "dreamfactory.properties";
    private static String requestURL;
    private static HttpURLConnection con;
    private static final int BUFFER_SIZE = 4096;

    /**
     * Uploads a file object to the server
     * @param File File object you want to upload
     * @return boolean stating whether file upload has been successful
     * @throws MalformedURLException
     * @throws ProtocolException
     * @throws IOException 
     */
    public static boolean uploadFile(File body) throws MalformedURLException,
            ProtocolException, IOException {
        //byte[] postData = body.toString().getBytes(StandardCharsets.UTF_8);
        byte[] postData = Files.readAllBytes(body.toPath());
        buildURL(body.getName());
        try {
            InputStream is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);
            String apiKey = props.getProperty("df.key");

            URL myurl = new URL(requestURL);
            con = (HttpURLConnection) myurl.openConnection();

            con.setDoOutput(true);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/octet-stream");
            con.setRequestProperty("X-DreamFactory-API-Key", apiKey);
            byte[] fileBytes = Files.readAllBytes(body.toPath());

            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.write(fileBytes);
            }

            StringBuilder content;

            try (BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()))) {

                String line;
                content = new StringBuilder();

                while ((line = in.readLine()) != null) {
                    content.append(line);
                    content.append(System.lineSeparator());
                }
            }
            body.delete();

            System.out.println(content.toString());

            return false;
        } finally {
            con.disconnect();
        }
    }

    public static void main(String[] args) {
        //buildURL("pic.jpg");
        try {
            File f = new File("C:\\Users\\Jordy\\Documents\\aether\\APPLICATION\\Aether\\web\\FTW202.docx");
            uploadFile(f);
            //byte[] pictureByte = f.getBytes();
            System.out.println(f.toString());
        } catch (MalformedURLException e) {

        } catch (IOException e) {

        }

    }

    /**
     * Gets a file from the server
     * @param fileName Name of the file you want to get
     * @param context servlet context to save the file (path)
     * @return File object
     * @throws MalformedURLException
     * @throws IOException 
     */
    public static File getFile(String fileName, String context) throws MalformedURLException, IOException {
        buildURL(fileName);

        URL obj = new URL(requestURL);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        String apiKey;
        con.setRequestMethod("GET");
        try {
            InputStream is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);
            apiKey = props.getProperty("df.key");
            con.setRequestProperty("X-DreamFactory-API-Key", apiKey);
        } catch (IOException e) {
            System.out.println("Unable to read API Key!");
        }

        int responseCode = con.getResponseCode();
        System.out.println("\nSending 'GET' request to URL : " + requestURL);
        System.out.println("Response Code : " + responseCode);

        File targetFile = new File(context + "\\" + fileName);
        InputStream inputStream = con.getInputStream();
        FileOutputStream outputStream = new FileOutputStream(context + "\\" + fileName);
        int bytesRead = -1;
        byte[] buffer = new byte[BUFFER_SIZE];
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        outputStream.close();
        inputStream.close();
        return new File(context + "\\" + fileName);
    }

    /**
     * Called within getFile and uploadFile
     * @param params name of the file you want to upload/download
     */
    private static void buildURL(String params) {
        InputStream is = null;
        try {
            // Retrieve properties from connection.properties via the CLASSPATH
            // WEB-INF/classes is on the CLASSPATH
            is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);

            // load database connection details
            String host = props.getProperty("df.files");
            String key = props.getProperty("df.key");

            requestURL = host + params;
        } catch (IOException ex) {
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
                    Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING, "Unable to close dreamfactory.properties", ex);
                }
            }
        }
    }
}
