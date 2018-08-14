/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 *
 * @author clare
 */
public class Zipper {
    public static File zipFiles(List<String> files, String path, String UUID){
        FileOutputStream fos = null;
        ZipOutputStream zipOut = null;
        FileInputStream fis = null;
        File input = null;
        try {
            String fileP = path + "\\" + UUID + ".zip";
            System.out.println(fileP);
            fos = new FileOutputStream(fileP);
            zipOut = new ZipOutputStream(new BufferedOutputStream(fos));
            for(String filePath:files){
                input = new File(filePath);
                fis = new FileInputStream(input);
                ZipEntry ze = new ZipEntry(input.getName());
                System.out.println("Zipping the file: "+input.getName());
                zipOut.putNextEntry(ze);
                byte[] tmp = new byte[4*1024];
                int size = 0;
                while((size = fis.read(tmp)) != -1){
                    zipOut.write(tmp, 0, size);
                }
                zipOut.flush();
                fis.close();
            }
            zipOut.close();
            System.out.println("Done... Zipped the files...");
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally{
            try{
                if(fos != null) fos.close();
            } catch(Exception ex){
                 
            }
        }
        return input;
    }
     
    public static void main(String a[]){
        Zipper zipper = new Zipper();
        List<String> files = new ArrayList<String>();
        files.add("C:\\Users\\clare\\Desktop\\uploadtest\\abc.txt");
        files.add("C:\\Users\\clare\\Desktop\\uploadtest\\download.jpg");
        //zipper.zipFiles(files);
    }
}
