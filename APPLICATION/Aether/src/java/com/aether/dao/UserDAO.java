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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author clare
 */
public class UserDAO {

    private Connection connection;

    public UserDAO() {
        try {
            connection = ConnectionManager.getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertUser(User user) {
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement("insert into aether.user(userid,password,publickey) values (?,?,?)");) {
            preparedStatement.setString(1, user.getUserid());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getPublicKey());

            preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public static String authenticate(String username) {
        String password = null;

        // Retrieve username from SQL Database
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
