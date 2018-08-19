/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blockchain;

import java.net.*;
import java.util.*;
import java.io.*;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import org.json.simple.*;
import org.json.simple.parser.*;

/**
 *
 * @author Jordy
 */
public class BlockchainHandler {

    private static HttpURLConnection con;
    private static final String URL = "http://127.0.0.1:8545";
    private static final double ETHTOWEI = 1000000000000000000.0;

    public static void main(String[] args) {
        //System.out.println(sendTransaction("0x9411c7c7E859d79FF025053137D32Db7431DDcB5", "0x7397fcf65152b25701a9F8640a2aEc6808209f61", 50.0).toString());
        //System.out.println(createAccount("password"));
    }

    public static double ethToWei(double eth) {
        return eth * ETHTOWEI;
    }

    public static String sendPostRequest(JSONObject body) throws MalformedURLException,
            ProtocolException, IOException {
        byte[] postData = body.toString().getBytes(StandardCharsets.UTF_8);
        try {
            URL myurl = new URL(URL);
            con = (HttpURLConnection) myurl.openConnection();

            con.setDoOutput(true);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");

            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.write(postData);
            }

            StringBuilder content;

            try (BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()))) {

                String line;
                content = new StringBuilder();

                while ((line = in.readLine()) != null) {
                    content.append(line);
                    content.append(System.lineSeparator());
                }
            }

            System.out.println(content.toString());

            return content.toString();
        } finally {
            con.disconnect();
        }
    }

    public static JSONObject getJSONObject(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        return (JSONObject) parser.parse(jsonString);
    }

    public static String toHex(String arg) {
        return String.format("%x", new BigInteger(1, arg.getBytes()));
    }

    public static String toHexValue(int toHex) {
        return Integer.toHexString(toHex);
    }

    public static String getReceipt(String transactionHash) {
        JSONObject receiptJSON = new JSONObject();
        receiptJSON.put("jsonrpc", "2.0");
        receiptJSON.put("method", "eth_getTransactionReceipt");
        JSONArray receiptParams = new JSONArray();
        receiptParams.add(transactionHash);
        receiptJSON.put("params", receiptParams);
        receiptJSON.put("id", 1);
        try {
            String finalRes = sendPostRequest(receiptJSON);
            return finalRes;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }
        return null;
    }

    public static String deployContract(String address, String uuid, String hash) {
        String contract = "0x60806040526000600260006101000a81548160ff02191690831515021790555034801561002b57600080fd5b506040516104a63803806104a68339810180604052810190808051820192919060200180518201929190505050816000908051906020019061006e92919061008d565b50806001908051906020019061008592919061008d565b505050610132565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100ce57805160ff19168380011785556100fc565b828001600101855582156100fc579182015b828111156100fb5782518255916020019190600101906100e0565b5b509050610109919061010d565b5090565b61012f91905b8082111561012b576000816000905550600101610113565b5090565b90565b610365806101416000396000f300608060405260043610610062576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806309bd5a60146100675780639e17f6ef146100f7578063bb07e85d1461010e578063bbb82d891461019e575b600080fd5b34801561007357600080fd5b5061007c6101cd565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100bc5780820151818401526020810190506100a1565b50505050905090810190601f1680156100e95780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561010357600080fd5b5061010c61026b565b005b34801561011a57600080fd5b50610123610288565b6040518080602001828103825283818151815260200191508051906020019080838360005b83811015610163578082015181840152602081019050610148565b50505050905090810190601f1680156101905780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156101aa57600080fd5b506101b3610326565b604051808215151515815260200191505060405180910390f35b60018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102635780601f1061023857610100808354040283529160200191610263565b820191906000526020600020905b81548152906001019060200180831161024657829003601f168201915b505050505081565b6001600260006101000a81548160ff021916908315150217905550565b60008054600181600116156101000203166002900480601f01602080910402602001604051908101604052809291908181526020018280546001816001161561010002031660029004801561031e5780601f106102f35761010080835404028352916020019161031e565b820191906000526020600020905b81548152906001019060200180831161030157829003601f168201915b505050505081565b600260009054906101000a900460ff16815600a165627a7a723058206ed0c06a21d2c55681c7914a26a16e4143165c3e756535849ddf93da6e3771fa0029";
        contract += "0000000000000000000000000000000000000000000000000000000000000040";
        contract += "00000000000000000000000000000000000000000000000000000000000000a0";
        contract += "0000000000000000000000000000000000000000000000000000000000000024";
        String uuidHex = toHex(uuid);
        while (uuidHex.length() < 128) {
            uuidHex += "0";
        }
        contract += uuidHex;
        contract += "0000000000000000000000000000000000000000000000000000000000000040";
        String hashHex = toHex(hash);
        contract += hashHex;

        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_sendTransaction");
        JSONArray params = new JSONArray();
        JSONObject contractParams = new JSONObject();
        contractParams.put("from", address);
        contractParams.put("gas", "0x2DC6C0");
        contractParams.put("data", contract);
        params.add(contractParams);
        body.put("params", params);
        body.put("id", 1);
        System.out.println(body.toString());
        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }

        return null;
    }

    public static String callContractParams(String address, String method) {
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_call");

        JSONArray params = new JSONArray();
        JSONObject contractParams = new JSONObject();
        contractParams.put("to", address);
        contractParams.put("data", method);
        params.add(contractParams);
        params.add("latest");

        body.put("params", params);
        body.put("id", 1);
        System.out.println(body.toString());
        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }

        return null;
    }
    
    public static String setVerified(String from, String to){
        String methodHash = "0x9e17f6ef";
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_sendTransaction");

        JSONObject params = new JSONObject();
        params.put("from", from);
        params.put("to", to);
        params.put("gas", "0x2dc6c0");
        params.put("data", methodHash);
        JSONArray parameters = new JSONArray();
        parameters.add(params);
        body.put("params", parameters);
        body.put("id", 1);

        System.out.println("body: " + body.toJSONString());

        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }

        return null;
    }

    public static String sendTransaction(String from, String to, int value) {
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_sendTransaction");

        JSONObject params = new JSONObject();
        params.put("from", from);
        params.put("to", to);
        params.put("value", toHexValue(value));
        JSONArray parameters = new JSONArray();
        parameters.add(params);
        body.put("params", parameters);
        body.put("id", 1);

        System.out.println("body: " + body.toJSONString());

        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }

        return null;
    }

    public static String createAccount(String password) {
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "personal_newAccount");
        JSONArray params = new JSONArray();
        params.add(password);
        body.put("params", params);
        body.put("id", 1);
        System.out.println(body.toString());
        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }

        return null;
    }

    public static String unlockAccount(String publicKey, String password) {
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "personal_unlockAccount");
        JSONArray params = new JSONArray();
        params.add(publicKey);
        params.add(password);
        body.put("params", params);
        body.put("id", 67);
        System.out.println(body.toString());
        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }
        return null;
    }

    public static String getBalance(String publicKey) {
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_getBalance");
        JSONArray params = new JSONArray();
        params.add(publicKey);
        params.add("latest");
        body.put("params", params);
        body.put("id", 1);
        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }
        return null;
    }

    public static String getListOfAccounts() {
        JSONObject body = new JSONObject();
        body.put("jsonrpc", "2.0");
        body.put("method", "eth_accounts");
        body.put("params", new JSONArray());
        body.put("id", 1);
        try {
            String result = sendPostRequest(body);
            return result;
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL!");
        } catch (ProtocolException f) {
            System.out.println("Protocol Exception!");
        } catch (IOException e) {
            System.out.println("IO Exception!");
        }

        return null;
    }
}
