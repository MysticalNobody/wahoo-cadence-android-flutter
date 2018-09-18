package com.example.oculusvrdemo;

import android.util.Log;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.Socket;

import static com.example.oculusvrdemo.Sensor.connected;


public class TcpSender extends Thread { //отправка самого сообщения
    Socket s;

    public TcpSender(Socket i1) {
        s = i1;
        start();
    }

    public void run() {
        try {
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(s.getOutputStream()));
            while (true) {
                if (DataToSend.data != null && connected && !DataToSend.sended) {
                    Log.w("Sender", "Send "+String.valueOf(DataToSend.data.getCrankSpeed().asRevolutionsPerMinute()));
                    bw.write(String.valueOf(DataToSend.data.getCrankSpeed().asRevolutionsPerMinute()) + "\n");
                    DataToSend.sended = true;
                    bw.flush();
                    Thread.sleep(100);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}