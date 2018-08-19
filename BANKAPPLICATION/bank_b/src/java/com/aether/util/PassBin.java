/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import com.aether.blockchain.BlockchainHandler;
import com.aether.util.Unzipper;
import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            File file = new File("C:/Users/Chuanyi/Desktop/UDI_asdasd.bin");
            byte[] bytes = new byte[(int) file.length()];
            DataInputStream dataInputStream = new DataInputStream(new BufferedInputStream(new FileInputStream("C:/Users/Chuanyi/Desktop/UDI_asdasd.bin")));
            dataInputStream.readFully(bytes);
            dataInputStream.close();
            String binContent = new String(bytes);
            
            System.out.println(binContent);
            
            JSONParser parser = new JSONParser();
            JSONObject jObj = (JSONObject) parser.parse(binContent);
            String tranHash = (String) jObj.get("transactionHash");
            System.out.println("transaction Hash:" + tranHash);

            String contractAdd = BlockchainHandler.getContractAddress(tranHash);
            System.out.println("ContractAdd: " + contractAdd);
            String uuid = BlockchainHandler.getUUID(contractAdd);
            System.out.println("uuid: " + uuid);
            String hash = BlockchainHandler.getHash(contractAdd);
            System.out.println("hash: " + hash);

            File zipFile = FileHandler.getFile(uuid + ".zip", request.getServletContext().getRealPath("/"));

            String keccakHash = BlockchainHandler.keccak256hash(zipFile);

            if (!keccakHash.equals(hash)) {
                //abort
            }
            else {
                request.getServletContext().getRealPath("/");
                ArrayList<File> fileList = Unzipper.unzip(zipFile.getPath(),request.getServletContext().getRealPath("/"));
                
                for(File f: fileList) {
                    if(f.getName().indexOf("picture") != -1) {
                        if(f.getName().indexOf("userdata") != -1) {
                            if(f.getName().indexOf("json") != -1) {
                                byte[] encoded = Files.readAllBytes(Paths.get(f.getPath()));
                                out.println(new String(encoded));
                                
                            }
                        }
                    }
                }
            }
            
            System.out.println(request.getServletContext().toString());
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(PassBin.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(PassBin.class.getName()).log(Level.SEVERE, null, ex);
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
