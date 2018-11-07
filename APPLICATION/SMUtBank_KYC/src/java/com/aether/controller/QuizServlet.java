/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import com.aether.dao.QuestionDAO;
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
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Yuefeng
 */
@WebServlet(name = "QuizServlet", urlPatterns = {"/QuizServlet"})
public class QuizServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

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
        response.setContentType("application/json");

        //overall result to return
        JSONObject result = new JSONObject();
        JSONArray setAResult = new JSONArray();
        JSONArray setBResult = new JSONArray(); 
        
        String categoryQ1 = "";
        String questionQ1 = "";
        String choicesQ1 = "";
        String questionAnsQ1 = "";

        try(PrintWriter out = response.getWriter()){
            QuestionDAO qnsdao = new QuestionDAO();
            org.json.simple.JSONArray setA = qnsdao.getSetA();
            if (setA != null) {
                int qID = 111;
                
                for (int num = 0; num < 3; num++) {
                    String qnsIDString = qID + "";
                    JSONObject populateQns = new JSONObject();
                    JSONObject qns = (JSONObject) setA.get(num);
                    if (qns != null) {
                        categoryQ1 = qns.getString("category");
                        questionQ1 = qns.getString("question");
                        choicesQ1 = qns.getString("choices");

                        JSONObject getQnsAns = qnsdao.getQuestionAnswer(qnsIDString);
                        if (getQnsAns != null) {
                            questionAnsQ1 = getQnsAns.getString("answer");
                        }

                        populateQns.put("questionID", qnsIDString);
                        populateQns.put("question", questionQ1);
                        populateQns.put("choices", choicesQ1);
                        populateQns.put("answer", questionAnsQ1);
                        //System.out.println("Test" + populateQns);
                        setAResult.put(populateQns);
                        
                        //setAResult.add(populateQns);
                    }
                    qID = qID + 1;
                }
                result.put("setA", setAResult);
            }else{
                result =null;
            }
            //set B 
            org.json.simple.JSONArray setB = qnsdao.getSetB();
            if (setB != null) {
                int qID = 114;
                
                for (int num = 0; num < 3; num++) {
                    String qnsIDString = qID + "";
                    JSONObject populateQns = new JSONObject();
                    JSONObject qns = (JSONObject) setB.get(num);
                    if (qns != null) {
                        categoryQ1 = qns.getString("category");
                        questionQ1 = qns.getString("question");
                        choicesQ1 = qns.getString("choices");

                        JSONObject getQnsAns = qnsdao.getQuestionAnswer(qnsIDString);
                        if (getQnsAns != null) {
                            questionAnsQ1 = getQnsAns.getString("answer");
                        }

                        populateQns.put("questionID", qnsIDString);
                        populateQns.put("question", questionQ1);
                        populateQns.put("choices", choicesQ1);
                        populateQns.put("answer", questionAnsQ1);
                        //System.out.println("Test" + populateQns);
                        setBResult.put(populateQns);
                        
                        //setAResult.add(populateQns);
                    }
                    qID = qID + 1;
                }
                result.put("setB", setBResult);
            }
            else{
                result =null;
            }
            if(result!= null){
            out.println(result.toString());
            }
            else{
                out.println("fail");
            }
            //org.json.simple.JSONArray setB = qnsdao.getSetB();

        } catch (Exception e) {

            e.printStackTrace(System.out);

        }

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
