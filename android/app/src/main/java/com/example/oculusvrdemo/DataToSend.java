package com.example.oculusvrdemo;


import com.wahoofitness.connector.capabilities.CrankRevs;

import java.util.HashMap;

public class DataToSend {
    static boolean sended = false;
    static CrankRevs.Data data;
    static HashMap<String,String> dataToMap(){
        HashMap<String,String> output = new HashMap<String, String>();
        output.put("Rpm",String.valueOf(data.getCrankSpeed().asRevolutionsPerMinute()));
        output.put("CrankRevs",String.valueOf(data.getCrankRevs()));
        return output;
    }
}
