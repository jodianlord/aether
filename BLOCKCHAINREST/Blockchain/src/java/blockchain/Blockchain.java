package blockchain;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Jordy
 */
public class Blockchain extends HttpServlet {

    private static final String PROPS_FILENAME = "blockchain.properties";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response, boolean isPost)
            throws ServletException, IOException {
        String apikey = request.getHeader("X-Blockchain-Key");

        if (!checkApiKey(apikey)) {
            response.setContentType("application/json");
            JSONObject error = new JSONObject();
            error.put("error", "Please set header X-Blockchain-Key to the api key from the administrator");
            try (PrintWriter out = response.getWriter()) {
                out.println(error.toString());
            }
            request.getSession().invalidate();
            return;
        }
        response.setContentType("application/json");
        if (request.getParameter("sendRaw") != null && request.getParameter("sendRaw").equals("true")) {
            JSONParser parser = new JSONParser();
            String payloadRequest = getBody(request);
            try {
                JSONObject body = (JSONObject) parser.parse(payloadRequest);
                String result = BlockchainHandler.sendPostRequest(body);
                try (PrintWriter out = response.getWriter()) {
                    out.println(result);
                }
            } catch (ParseException e) {
                JSONObject error = new JSONObject();
                error.put("error", "parse exception occurred");
                try (PrintWriter out = response.getWriter()) {
                    out.println(error.toString());
                }
            }
            return;
        }
        if (!isPost) {
            String method = request.getParameter("method");
            if (method == null) {
                return;
            }
            if (method.equals("getListOfAccounts")) {
                String result = BlockchainHandler.getListOfAccounts();
                try (PrintWriter out = response.getWriter()) {
                    out.println(result);
                }
            } else if (method.equals("getBalance")) {
                String publicKey = request.getParameter("publickey");
                String result = BlockchainHandler.getBalance(publicKey);
                try (PrintWriter out = response.getWriter()) {
                    out.println(result);
                }
            }
        } else {
            String payloadRequest = getBody(request);
            JSONParser parser = new JSONParser();
            try {
                JSONObject requestChecker = (JSONObject) parser.parse(payloadRequest);
                String method = (String) requestChecker.get("method");
                if (method.equals("createAccount")) {
                    JSONObject param = (JSONObject) requestChecker.get("param");
                    String password = (String) param.get("password");
                    String result = BlockchainHandler.createAccount(password);
                    try (PrintWriter out = response.getWriter()) {
                        out.println(result);
                    }
                } else if (method.equals("sendTransaction")) {
                    JSONObject param = (JSONObject) requestChecker.get("param");
                    String from = (String) param.get("from");
                    String to = (String) param.get("to");
                    long value = (Long) param.get("value");
                    String result = BlockchainHandler.sendTransaction(from, to, value);
                    try (PrintWriter out = response.getWriter()) {
                        out.println(result);
                    }
                } else if (method.equals("unlockAccount")) {
                    JSONObject param = (JSONObject) requestChecker.get("param");
                    String publicKey = (String) param.get("publicKey");
                    String password = (String) param.get("password");
                    String result = BlockchainHandler.unlockAccount(publicKey, password);
                    try (PrintWriter out = response.getWriter()) {
                        out.println(result);
                    }
                }
            } catch (ParseException e) {
                JSONObject error = new JSONObject();
                error.put("error", "parse exception occurred");
                try (PrintWriter out = response.getWriter()) {
                    out.println(error.toString());
                }
            }
        }
        request.getSession().invalidate();
    }

    public static String getBody(HttpServletRequest request) throws IOException {

        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            } else {
                stringBuilder.append("");
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }

        body = stringBuilder.toString();
        return body;
    }

    public static boolean checkApiKey(String apikey) {
        InputStream is = null;
        try {
            // Retrieve properties from connection.properties via the CLASSPATH
            // WEB-INF/classes is on the CLASSPATH
            is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);

            // load database connection details
            String api = props.getProperty("api.key");
            return api.equals(apikey);
        } catch (Exception ex) {
            // unable to load properties file
            String message = "Unable to load '" + PROPS_FILENAME + "'.";

            System.out.println(message);
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
            throw new RuntimeException(message, ex);
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException ex) {
                    Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING, "Unable to close dreamfactory.properties", ex);
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response, false);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response, true);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
