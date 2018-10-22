/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author jordysamuel
 */
public class JDBCHandler {

    public static void main(String[] args) {
        Map<String, String> queryMap = new HashMap<String, String>();
        queryMap.put("userid", "beebee");
        queryMap.put("password", "wheeee");
        queryMap.put("publickey", "wjeja");
    }

    public static JSONArray getRecordsFromTable(String table, Map<String, String> criteria) throws SQLException {
        Connection con = ConnectionManager.getConnection();
        int questionCount = 0;

        String query = "SELECT * FROM " + table + " WHERE ";

        if (criteria == null || criteria.isEmpty()) {
            return null;
        }

        Iterator it = criteria.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry) it.next();
            query += pair.getKey();
            query += " = ?";
            if (it.hasNext()) {
                query += " AND ";
            }
        }
        //System.out.println(query);
        PreparedStatement pstmt = con.prepareStatement(query);

        it = criteria.entrySet().iterator();
        while (it.hasNext()) {
            questionCount++;
            Map.Entry pair = (Map.Entry) it.next();
            pstmt.setString(questionCount, (String) pair.getValue());
        }
        
        ResultSet rs = pstmt.executeQuery();
        
        JSONArray resultArray = new JSONArray();
        while(rs.next()){
            JSONObject resultObj = new JSONObject();
            resultObj.put("userid", rs.getString(1));
            resultObj.put("password", rs.getString(2));
            resultObj.put("publickey", rs.getString(3));
            resultArray.add(resultObj);
        }
        
        con.close();
        return resultArray;
    }

    public static ResultSet createRecords(String table, Map<String, String> data) throws SQLException{
        Connection con = ConnectionManager.getConnection();
        
        String query = "INSERT INTO " + table + "(";
        
        Iterator it = data.entrySet().iterator();
        while(it.hasNext()){
            Map.Entry pair = (Map.Entry) it.next();
            String key = (String) pair.getKey();
            query += key;
            if(it.hasNext()){
                query += ",";
            }else{
                query += ")";
            }
        }
        
        query += " VALUES (";
        
        for(int i = 0; i < data.size(); i++){
            query += "?";
            if(i < data.size() - 1){
                query += ",";
            }else{
                query += ")";
            }
        }
        
        PreparedStatement pstmt = con.prepareStatement(query);
        
        it = data.entrySet().iterator();
        int qCount = 1;
        while(it.hasNext()){
            Map.Entry pair = (Map.Entry) it.next();
            String value = (String) pair.getValue();
            pstmt.setString(qCount, value);
            qCount++;
        }
        
        pstmt.executeUpdate();
        
        return null;
    }
}
