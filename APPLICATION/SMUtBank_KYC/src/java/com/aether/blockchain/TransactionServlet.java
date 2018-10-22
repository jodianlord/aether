package com.aether.blockchain;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.aether.util.Dreamfactory;
import com.aether.util.JDBCHandler;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Jordy
 */
public class TransactionServlet extends HttpServlet {

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
        try {
            response.setContentType("text/html;charset=UTF-8");
            String userFrom = request.getParameter("from");
            String userTo = request.getParameter("to");
            String password = request.getParameter("password");
            String value = request.getParameter("value");
            
            System.out.println("userfrom: " + userFrom + " userTo: " + userTo);
            
            System.out.println("double: " + Double.parseDouble(value));
            
            HashMap<String,String> filterFrom = new HashMap<String,String>();
            filterFrom.put("userid", userFrom);
            
            HashMap<String,String> filterTo = new HashMap<String,String>();
            filterTo.put("userid", userTo);
            
            JSONArray fromPublicKey = JDBCHandler.getRecordsFromTable("user", filterFrom);
            System.out.println("From: " + fromPublicKey);
            
            JSONArray toPublicKey = JDBCHandler.getRecordsFromTable("user", filterTo);
            System.out.println("To: " + toPublicKey);
            
            if(fromPublicKey.size() == 0 || toPublicKey.size() == 0){
                response.setStatus(400);
                return;
            }
            
            JSONObject fromRecord = (JSONObject) fromPublicKey.get(0);
            String fromPub = (String) fromRecord.get("publickey");
            fromPub = fromPub.replace("\u0000", "");
            if(!BlockchainHandler.unlockAccount(fromPub, password)){
                response.setStatus(400);
                return;
            }
            
            JSONObject toRecord = (JSONObject) toPublicKey.get(0);
            String toPub = (String) toRecord.get("publickey");
            toPub = toPub.replace("\u0000", "");
            
            String result = BlockchainHandler.sendTransaction(fromPub, toPub, Integer.parseInt(value));
            
            System.out.println("Result: " + result);
            
            response.setStatus(200);
            return;
            
            /*
            try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            /*
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TransactionServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println(request.getParameter("from"));
            out.println(request.getParameter("to"));
            out.println("<h1>Servlet TransactionServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            }
            */
        } catch (SQLException ex) {
            Logger.getLogger(TransactionServlet.class.getName()).log(Level.SEVERE, null, ex);
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
