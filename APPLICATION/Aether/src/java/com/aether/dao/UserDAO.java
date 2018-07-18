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
        try {
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement("insert into user(userid,password,publickey,privatekey) values (?,?,?,?)");
            preparedStatement.setString(1, user.getUserid());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getPublickey());
            preparedStatement.setString(4, user.getPrivatekey());

            preparedStatement.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

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
            PreparedStatement preparedStatement = connection.prepareStatement("update user set userid=?, password=?, publickey=?, privatekey=? where userid=?");
            // Parameters start with 1
            preparedStatement.setString(1, user.getUserid());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getPublickey());
            preparedStatement.setString(4, user.getPrivatekey());
            preparedStatement.setString(5, user.getUserid());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}