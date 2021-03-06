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
        try {
            Map<String, String> criteria = new HashMap<String, String>();
            criteria.put("uuid", "3d99eca9-25cd-499a-8dd2-d1301f03809a");
            JSONArray array = getContracts("contract", criteria);
            JSONObject obj = (JSONObject) array.get(0);
            //System.out.println(obj.toString());
        } catch (SQLException ex) {
            Logger.getLogger(JDBCHandler.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static JSONArray getContracts(String table, Map<String, String> criteria) throws SQLException {
        Connection con = ConnectionManager.getConnection();
        int questionCount = 0;

        String query = "SELECT * FROM " + table;

        if (criteria == null || criteria.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            JSONArray resultArray = new JSONArray();
            while (rs.next()) {
                JSONObject resultObj = new JSONObject();
                resultObj.put("transaction_address", rs.getString(1));
                resultObj.put("uuid", rs.getString(2));
                resultObj.put("facial_encoding", rs.getString(3));
                resultObj.put("contract_address", rs.getString(4));
                resultObj.put("json_data", rs.getString(5));
                resultObj.put("integrity_hash", rs.getString(6));
                resultArray.add(resultObj);
            }

            con.close();
            return resultArray;
        } else {
            query += " WHERE ";
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
        while (rs.next()) {
            JSONObject resultObj = new JSONObject();
            resultObj.put("transaction_address", rs.getString(1));
            resultObj.put("uuid", rs.getString(2));
            resultObj.put("facial_encoding", rs.getString(3));
            resultObj.put("contract_address", rs.getString(4));
            resultObj.put("json_data", rs.getString(5));
            resultObj.put("integrity_hash", rs.getString(6));
            resultArray.add(resultObj);
        }

        con.close();
        return resultArray;
    }

    public static JSONArray getUserRecordsFromTable(String table, Map<String, String> criteria) throws SQLException {
        Connection con = ConnectionManager.getConnection();
        int questionCount = 0;

        String query = "SELECT * FROM " + table;

        if (criteria == null || criteria.isEmpty()) {
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            JSONArray resultArray = new JSONArray();
            while (rs.next()) {
                JSONObject resultObj = new JSONObject();
                resultObj.put("userid", rs.getString(1));
                resultObj.put("password", rs.getString(2));
                resultObj.put("publickey", rs.getString(3));
                resultArray.add(resultObj);
            }

            con.close();
            return resultArray;
        } else {
            query += " WHERE ";
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
        while (rs.next()) {
            JSONObject resultObj = new JSONObject();
            resultObj.put("userid", rs.getString(1));
            resultObj.put("password", rs.getString(2));
            resultObj.put("publickey", rs.getString(3));
            resultArray.add(resultObj);
        }

        con.close();
        return resultArray;
    }

    public static ResultSet createRecords(String table, Map<String, String> data) throws SQLException {
        Connection con = ConnectionManager.getConnection();

        String query = "INSERT INTO " + table + "(";

        Iterator it = data.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry) it.next();
            String key = (String) pair.getKey();
            query += key;
            if (it.hasNext()) {
                query += ",";
            } else {
                query += ")";
            }
        }

        query += " VALUES (";

        for (int i = 0; i < data.size(); i++) {
            query += "?";
            if (i < data.size() - 1) {
                query += ",";
            } else {
                query += ")";
            }
        }

        PreparedStatement pstmt = con.prepareStatement(query);

        it = data.entrySet().iterator();
        int qCount = 1;
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry) it.next();
            String value = (String) pair.getValue();
            pstmt.setString(qCount, value);
            qCount++;
        }

        pstmt.executeUpdate();

        return null;
    }
}
