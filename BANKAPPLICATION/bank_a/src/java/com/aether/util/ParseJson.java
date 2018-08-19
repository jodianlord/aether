/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author clare
 */
@WebServlet(name = "ParseJson", urlPatterns = {"/ParseJson"})
public class ParseJson extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
             String jsonData = "{\n"
                    + "    \"fullname\": \"Lim Yuefeng\",\n"
                    + "    \"nric\": \"S9411234H\",\n"
                    + "    \"email\": \"xiaofeng@gmail.com\",\n"
                    + "    \"mobile\": \"96480052\",\n"
                    + "    \"gender\": \"Female\",\n"
                    + "    \"nationality\": \"Singaporean\",\n"
                    + "    \"marital\": \"Divorced\",\n"
                    + "    \"residencetype\": \"HDB\",\n"
                    + "    \"address\": \"Blk 665 Yishun Ave 6 #06-123 (S)567890\",\n"
                    + "    \"occupation\": \"Student\",\n"
                    + "    \"industry\": \"NIL\"\n"
                    + "}";
            out.println(jsonData);
        }
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
