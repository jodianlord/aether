/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import com.aether.dao.SendSMSDAO;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Random;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet(name = "CreateCustomerServlet", urlPatterns = {"/CreateCustomerServlet"})
public class CreateCustomerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");

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
        response.setContentType("application/json");
                


        String apiServiceUrl = "http://tbankonline.com/SMUtBank_API/Gateway";
        String body = getBody(request);
        try {
            org.json.simple.JSONObject jsonContent = getJSONObject(body);
            //org.json.simple.JSONObject resultJSON = getJSONObject(body);
            String nric = (String) jsonContent.get("nric");
            String fullname = (String) jsonContent.get("fullname");
            String email = (String) jsonContent.get("email");
            String mobile = (String) jsonContent.get("mobile");
            String gender = (String) jsonContent.get("gender");
            String marital = (String) jsonContent.get("marital");
            String address = (String) jsonContent.get("address");
            String occupation = (String) jsonContent.get("occupation");
            
            
            
            // build header
            JSONObject jo = new JSONObject();
            jo.put("serviceName", "onboardCustomer");
            jo.put("userID", ""); 
            jo.put("PIN", ""); 
            jo.put("OTP", ""); 
            JSONObject headerObj = new JSONObject();
            headerObj.put("Header", jo);
            String header = headerObj.toString();
            System.out.println("wtf header");
            //set inputs into json object 
            jo = new JSONObject();
            jo.put("IC_number", nric);	// this must be unique, otherwise "duplicate" error.
            jo.put("familyName", "Lee"); //fyi this is hardcoded for now
            jo.put("givenName", fullname);
            jo.put("dateOfBirth", "1994-12-12");
            jo.put("gender", gender);
            jo.put("occupation", occupation);
            jo.put("streetAddress", address);
            jo.put("city", "Singapore");
            jo.put("state", "Singapore");
            jo.put("country", "Singapore");
            jo.put("postalCode", "760123");
            jo.put("emailAddress", email);
            jo.put("countryCode", "+65");
            jo.put("mobileNumber", mobile);
            jo.put("preferredUserID", nric);
            jo.put("currency", "SGD");
            jo.put("bankID", "1");
            
            /*
            jo.put("IC_number", request.getParameter("nric"));	// this must be unique, otherwise "duplicate" error.
            jo.put("familyName", "");
            jo.put("givenName", request.getParameter("fullname"));
            jo.put("dateOfBirth", "1994-12-12");
            jo.put("gender", request.getParameter("gender"));
            jo.put("occupation", request.getParameter("occupation"));
            jo.put("streetAddress", request.getParameter("address"));
            jo.put("city", request.getParameter("Singapore"));
            jo.put("state", request.getParameter("Singapore"));
            jo.put("country", request.getParameter("Singapore"));
            jo.put("postalCode", "760123");
            jo.put("emailAddress", request.getParameter("email"));
            jo.put("countryCode", "+65");
            jo.put("mobileNumber", request.getParameter("mobile"));
            jo.put("preferredUserID", request.getParameter("nric"));
            jo.put("currency", "SGD");
            jo.put("bankID", "1");
            
            */
            System.out.println("help see this>>"+nric);
            System.out.println("wtf jo");
            //set content
            JSONObject contentObj = new JSONObject();
            contentObj.put("Content", jo);
            String content = contentObj.toString();
            System.out.println("wtf content");
            // connect to API service 
            HttpURLConnection urlConnection = (HttpURLConnection) new URL(apiServiceUrl).openConnection();
            urlConnection.setDoOutput(true);
            urlConnection.setRequestMethod("POST");
            System.out.println("wtf post");
            // build request parameters
            String parameters
                    = "Header=" + header + "&"
                    + "Content=" + content;

            // send request
            BufferedWriter br = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
            br.write(parameters);
            br.close();
System.out.println("wtf buffer");
            // get response
            String resp = "";
            Scanner s = new Scanner(urlConnection.getInputStream());
            while (s.hasNextLine()) {
                resp += s.nextLine();
            }
            s.close();
System.out.println("wtf resp");
            // get response object
            JSONObject responseObj = new JSONObject(resp);
            System.out.println(responseObj.toString(4)); // indent 4 spaces
            System.out.println();
            //parse {"Content"}
System.out.println("wtf parse content");
            contentObj = responseObj.getJSONObject("Content");
            //parse {"ServiceResponse"}
            JSONObject serviceRespObj = contentObj.getJSONObject("ServiceResponse");
            //parse {"customer details"}
            JSONObject customerDetailsObj = serviceRespObj.getJSONObject("CustomerDetails");
            String accID = (String) customerDetailsObj.get("AccountID");
            String custID = customerDetailsObj.getString("CustomerID");
            String custPIN = customerDetailsObj.getString("PIN");
           
            System.out.println("wtf parse custdetails");
            //parseHeader
            JSONObject serviceRespHeaderObj = serviceRespObj.getJSONObject("ServiceRespHeader");
            String globalErrorID = serviceRespHeaderObj.getString("GlobalErrorID");
            String errorText = serviceRespHeaderObj.getString("ErrorText");
            Object errorDetails =  serviceRespHeaderObj.get("ErrorDetails");
            System.out.println("wtf parse error");
            //check for error:
            
            SendSMSDAO msg = new SendSMSDAO();
            msg.sendMessage( "96480053", "Your account has been created!"
                        + "Please use your NRIC as the username and "+"this is your PIN: "+custPIN+"");
            
System.out.println("wtf parse help");
        } catch (Exception e) {
            System.out.println("wtf exception");
            e.printStackTrace(System.out);

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

    public static org.json.simple.JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (org.json.simple.JSONObject) parser.parse(jsonString);
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
