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
import com.aether.util.ConnectionManager;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "SignUpServlet", urlPatterns = {"/SignUpServlet"})
public class SignUpServlet extends HttpServlet {
    
    private static final String PROPS_FILENAME = "connection.properties";
    private static String publickey;
    private UserDAO userdao;

    public SignUpServlet() {
        super();
        userdao = new UserDAO();
    }
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        readPublicKey();
        HttpSession session = request.getSession();
        String userid = request.getParameter("userid");
        userid = userid.toLowerCase();
        String password = request.getParameter("password");
        //String publickey = BlockchainHandler.createAccount("password");
        //publickey = publickey.replace("\u0000", "");
        //String publickey = "0x42e6671d1d489c47e3418557167a2373607996b8";
        //BlockchainHandler.unlockAccount("0x2d117903f7b2dc16abe2d6272d11d84233ff7c1f", "password");
        //BlockchainHandler.sendTransaction("0x2d117903f7b2dc16abe2d6272d11d84233ff7c1f", publickey, 1000000000);

        String hashedPWD = BCrypt.hashpw(password, BCrypt.gensalt(12));


        User existingUser =  userdao.getUser(userid);
        
        if(existingUser == null) { //do not exist
            User user = new User(userid, hashedPWD, SignUpServlet.publickey);
            userdao.insertUser(user);
            session.setAttribute("userError","donotexists");  
        } 
        else {
            session.setAttribute("userError","exist");
            
        }

//        session.setAttribute("error", hashedPWD);
    
        response.sendRedirect("index.jsp");

    }
    
    private static void readPublicKey() {
        InputStream is = null;
        try {
            // Retrieve properties from connection.properties via the CLASSPATH
            // WEB-INF/classes is on the CLASSPATH
            is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);

            // load database connection details
            SignUpServlet.publickey = props.getProperty("blockchain.address");
        } catch (Exception ex) {
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
                    Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING, "Unable to close connection.properties", ex);
                }
            }
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
