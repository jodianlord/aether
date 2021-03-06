/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;
import java.io.File;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
/**
 *
 * @author clare
 */
public class SendEmailSSL {
    
    
//    private final static String user = "aetherfyp@gmail.com";
//    private final static String pass = "aetherpassword";
    static Properties mailServerProperties;
    static Session getMailSession;
    static MimeMessage generateMailMessage;
    
    public static void main(String args[]) throws AddressException, MessagingException {
        generateAndSendEmail("jordysamuel@gmail.com", new File("C:\\Users\\jodia\\Documents\\aether\\APPLICATION\\Aether\\web\\0a4af52e-8c86-4009-882b-180464af09ff.zip"));
        System.out.println("\n\n ===> Your Java Program has just sent an Email successfully. Check your email..");
    }
 
	public static void generateAndSendEmail(String emailAddress, File f) throws AddressException, MessagingException {
 
		// Step1
		System.out.println("\n 1st ===> setup Mail Server Properties..");
		mailServerProperties = System.getProperties();
		mailServerProperties.put("mail.smtp.port", "587");
		mailServerProperties.put("mail.smtp.auth", "true");
		mailServerProperties.put("mail.smtp.starttls.enable", "true");
		System.out.println("Mail Server Properties have been setup successfully..");
 
		// Step2
		System.out.println("\n\n 2nd ===> get Mail Session..");
		getMailSession = Session.getDefaultInstance(mailServerProperties, null);
		generateMailMessage = new MimeMessage(getMailSession);
		generateMailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(emailAddress));
		//generateMailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress(emailAddress));
		generateMailMessage.setSubject("Your Universal Digital Identity key is ready!");
		String emailBody = "Attach the file in this email to activate digital services. The future awaits! " + "<br><br> Regards, <br>AETHER Admin";
		//generateMailMessage.setContent(emailBody, "text/html");
                MimeBodyPart messagePart = new MimeBodyPart();
                messagePart.setText(emailBody, "UTF-8", "html");
		System.out.println("Mail Session has been created successfully..");
                
                FileDataSource fileDataSource = new FileDataSource(f.toPath().toString());
                MimeBodyPart attachmentPart = new MimeBodyPart();
                attachmentPart.setDataHandler(new DataHandler(fileDataSource));
                attachmentPart.setFileName(fileDataSource.getName());
                
                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(messagePart);
                multipart.addBodyPart(attachmentPart);
                
                generateMailMessage.setContent(multipart);
 
		// Step3
		System.out.println("\n\n 3rd ===> Get Session and Send mail");
		Transport transport = getMailSession.getTransport("smtp");
 
		// Enter your correct gmail UserID and Password
		// if you have 2FA enabled then provide App Specific Password
		transport.connect("smtp.gmail.com", "aetherfyp2018@gmail.com", "aetherpassword1");
		transport.sendMessage(generateMailMessage, generateMailMessage.getAllRecipients());
		transport.close();
	
	}
}

