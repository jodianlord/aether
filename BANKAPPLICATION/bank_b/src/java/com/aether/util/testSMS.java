/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;
import com.aether.dao.SendSMSDAO;
/**
 *
 * @author Yuefeng
 */
public class testSMS {
    public static void main(String[] args){
        
        SendSMSDAO s = new SendSMSDAO();
        s.sendMessage( "96480053", "Here is your pin and account ID");
        
        
    }
}
