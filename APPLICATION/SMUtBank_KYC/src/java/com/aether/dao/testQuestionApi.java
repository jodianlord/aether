/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aether.dao;
import com.aether.dao.QuestionDAO;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Yuefeng
 */
public class testQuestionApi {
    public static void main(String[] args){
        JSONObject result = new JSONObject();
        JSONArray setAResult = new JSONArray();
        JSONArray setBResult = new JSONArray();
        String categoryQ1 = "";
        String questionQ1 = "";
        String choicesQ1 = "";
        String questionAnsQ1 = "";

       
            QuestionDAO qnsdao = new QuestionDAO();
            org.json.simple.JSONArray setA = qnsdao.getSetA();
            if (setA != null) {
                int qID = 111;
                
                for (int num = 0; num < 3; num++) {
                    String qnsIDString = qID + "";
                    JSONObject populateQns = new JSONObject();
                    JSONObject qns = (JSONObject) setA.get(num);
                    if (qns != null) {
                        categoryQ1 = qns.getString("category");
                        questionQ1 = qns.getString("question");
                        choicesQ1 = qns.getString("choices");

                        JSONObject getQnsAns = qnsdao.getQuestionAnswer(qnsIDString);
                        if (getQnsAns != null) {
                            questionAnsQ1 = getQnsAns.getString("answer");
                        }

                        populateQns.put("questionID", qnsIDString);
                        populateQns.put("question", questionQ1);
                        populateQns.put("choices", choicesQ1);
                        populateQns.put("answer", questionAnsQ1);
                       // System.out.println("Test" + populateQns);
                        setAResult.put(populateQns);
                        //System.out.println(choicesQ1.split("&&"));
                        //setAResult.add(populateQns);
                    }
                    qID = qID + 1;
                }
                result.put("setA", setAResult);
                //System.out.println(setAResult);
                
            }
            org.json.simple.JSONArray setB = qnsdao.getSetB();
            if (setB != null) {
                int qID = 114;
                
                for (int num = 0; num < 3; num++) {
                    String qnsIDString = qID + "";
                    JSONObject populateQns = new JSONObject();
                    JSONObject qns = (JSONObject) setB.get(num);
                    if (qns != null) {
                        categoryQ1 = qns.getString("category");
                        questionQ1 = qns.getString("question");
                        choicesQ1 = qns.getString("choices");
                            
                        JSONObject getQnsAns = qnsdao.getQuestionAnswer(qnsIDString);
                        if (getQnsAns != null) {
                            questionAnsQ1 = getQnsAns.getString("answer");
                        }

                        populateQns.put("questionID", qnsIDString);
                        populateQns.put("question", questionQ1);
                        populateQns.put("choices", choicesQ1);
                        populateQns.put("answer", questionAnsQ1);
                        //System.out.println("Test" + populateQns);
                        setBResult.put(populateQns);
                        
                        //setAResult.add(populateQns);
                    }
                    qID = qID + 1;
                }
                result.put("setB", setBResult);
            }
        
        System.out.println(result);
    }
}
