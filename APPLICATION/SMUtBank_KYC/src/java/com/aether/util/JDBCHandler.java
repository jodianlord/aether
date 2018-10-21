/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jordysamuel
 */
public class JDBCHandler {
    
    public static void main(String[] args){
        Map<String, String> queryMap = new HashMap<String, String>();
        queryMap.put("userid", "jordysamuel");
        queryMap.put("password", "wheeee");
        queryMap.put("nono", "wjeja");
        try {
            getRecord("user", queryMap);
        } catch (SQLException ex) {
            Logger.getLogger(JDBCHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static Map<String, String> getRecord(String table, Map<String, String> criteria) throws SQLException{
        Connection con = ConnectionManager.getConnection();
        //Statement stmt = con.createStatement();
        
        int questionCount = 1;
        
        String query = "SELECT * FROM ? WHERE ";
        Iterator it = criteria.entrySet().iterator();
        while(it.hasNext()){
            Map.Entry pair =(Map.Entry)it.next();
            query += pair.getKey(); 
            query += " = ?";
            if(it.hasNext()){
                query += " AND ";
            }
        }
        System.out.println(query);
        return null;
    }
}
