/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.controller;

import com.aether.dao.UserDAO;
import com.aether.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.BCrypt;
import com.aether.blockchain.BlockchainHandler;

@WebServlet(name = "SignUpServlet", urlPatterns = {"/SignUpServlet"})
public class SignUpServlet extends HttpServlet {

    private UserDAO userdao;

    public SignUpServlet() {
        super();
        userdao = new UserDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession();
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");
        String publickey = BlockchainHandler.createAccount(password);
//        publickey = "test";

        //String privatekey = request.getParameter("privatekey");

        
        // Hash a password for the first time
//        String hashedPWD = BCrypt.hashpw(password, BCrypt.gensalt());

        // gensalt's log_rounds parameter determines the complexity
        // the work factor is 2**log_rounds, and the default is 10
        String hashedPWD = BCrypt.hashpw(password, BCrypt.gensalt(12));
        
//        System.out.print(hashedPWD);
        
        // Check that an unencrypted password matches one that has
        // previously been hashed
//        if (BCrypt.checkpw(candidate, hashed))
//                System.out.println("It matches");
//        else
//                System.out.println("It does not match");

        
        User user = new User(userid, hashedPWD, publickey);
        userdao.insertUser(user);

//        session.setAttribute("error", hashedPWD);
        response.sendRedirect("index.jsp");
        
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

