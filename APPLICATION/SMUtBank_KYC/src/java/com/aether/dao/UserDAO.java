/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.dao;

import com.aether.model.User;
import com.aether.util.ConnectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.aether.util.Dreamfactory;
import com.aether.util.JDBCHandler;
import java.util.ArrayList;
import java.util.Map;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author clare
 */
public class UserDAO {

    private Connection connection;

    public UserDAO() {
        /*
        try {
            connection = ConnectionManager.getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        */
    }
    
    public static void main(String[] args){
        User s = getUser("admin");
        System.out.println(s.getUserid() + " " + s.getPassword());
    }

    public void insertUser(User user) {
        HashMap<String, String> record = new HashMap<String, String>();
        record.put("userid", user.getUserid());
        record.put("password", user.getPassword());
        record.put("publickey", user.getPublicKey());
        ArrayList<Map<String,String>> toFeed = new ArrayList<Map<String,String>>();
        toFeed.add(record);
        System.out.println(Dreamfactory.createRecords("user", toFeed));
        
        /*
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement("insert into aether.user(userid,password,publickey) values (?,?,?)");) {
            preparedStatement.setString(1, user.getUserid());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getPublicKey());

            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        */
    }
    
    public static User getUser(String userid){
        HashMap<String, String> filter = new HashMap<String, String>();
        filter.put("userid", userid);
        JSONArray record = null;
        try {
            record = JDBCHandler.getRecordsFromTable("user", filter);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(record == null || record.size() == 0){
            return null;
        }
        JSONObject oneRecord = (JSONObject) record.get(0);
        User user = new User(userid, (String) oneRecord.get("password"), (String) oneRecord.get("publickey"));
        return user;
    }
    
    public static String authenticate(String username) {

        // Retrieve username from Dreamfactory
        
        HashMap<String, String> filter = new HashMap<String, String>();
        filter.put("userid", username);
        JSONArray record = Dreamfactory.getRecordsFromTable("user", filter);
        if(record == null || record.size() == 0){
            return null;
        }
        
        JSONObject user = (JSONObject) record.get(0);
        return (String) user.get("password");
        
        /*
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement pstmt = conn.prepareStatement("select password from aether.user where userid = ? ");) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                password = rs.getString("password");
            }
            // Invalid username
        } catch (SQLException ex) {
            return null;
        }
        return password;
        */
    }

    public void deleteUser(String userid) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from user where userid=?");
            // Parameters start with 1
            preparedStatement.setString(1, userid);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUser(User user) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("update user set userid=?, password=?, publickey=? where userid=?");
            // Parameters start with 1
            preparedStatement.setString(1, user.getUserid());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getPublicKey());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
