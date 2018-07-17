/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.model;

/**
 *
 * @author clare
 */
public class User {

    public User(String userid, String password, String publickey, String privatekey) {
        this.userid = userid;
        this.password = password;
        this.publickey = publickey;
        this.privatekey = privatekey;
    }
    
    private String userid;
    private String password;
    private String publickey;
    private String privatekey;


    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPublickey() {
        return publickey;
    }

    public void setPublickey(String publickey) {
        this.publickey = publickey;
    }

    public String getPrivatekey() {
        return privatekey;
    }

    public void setPrivatekey(String privatekey) {
        this.privatekey = privatekey;
    }
    
   
    
    
    
}
