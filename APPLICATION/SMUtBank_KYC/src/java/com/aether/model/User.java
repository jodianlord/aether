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

    public User(String userid, String password, String publicKey) {
        this.userid = userid;
        this.password = password;
        this.publicKey = publicKey;
    }
    
    private String userid;
    private String password;
    private String publicKey;

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

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

//    public String getPrivatekey() {
//        return privatekey;
//    }
//
//    public void setPrivatekey(String privatekey) {
//        this.privatekey = privatekey;
//    }

    
    
}
