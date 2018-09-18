package com.example.oculusvrdemo;

import android.content.Context;
import android.util.Log;

import com.wahoofitness.connector.HardwareConnector;
import com.wahoofitness.connector.HardwareConnectorEnums;
import com.wahoofitness.connector.HardwareConnectorTypes;
import com.wahoofitness.connector.capabilities.Capability;
import com.wahoofitness.connector.capabilities.CrankRevs;
import com.wahoofitness.connector.conn.connections.SensorConnection;
import com.wahoofitness.connector.conn.connections.params.ConnectionParams;
import com.wahoofitness.connector.listeners.discovery.DiscoveryListener;


public class Sensor implements DiscoveryListener, SensorConnection.Listener, CrankRevs.Listener {
    static boolean connected = false;
    Sensor(Context context){
        mHardwareConnector= new HardwareConnector(context ,mHardwareConnectorCallback);
        mHardwareConnector.startDiscovery(HardwareConnectorTypes.SensorType.BIKE_SPEED_CADENCE, HardwareConnectorTypes.NetworkType.BTLE,this );
    }
    public void onDestroy() {
        mHardwareConnector.disconnectAllSensors();
        mHardwareConnector.shutdown();
    }
    HardwareConnector mHardwareConnector;
    private final HardwareConnector.Callback mHardwareConnectorCallback=new HardwareConnector.Callback(){
        @Override
        public void connectorStateChanged(HardwareConnectorTypes.NetworkType networkType, HardwareConnectorEnums.HardwareConnectorState hardwareConnectorState) {

        }

        @Override
        public void connectedSensor(SensorConnection sensorConnection) {

        }

        @Override
        public void disconnectedSensor(SensorConnection sensorConnection) {
            connected = false;
        }

        @Override
        public void hasData() {

        }

        @Override
        public void onFirmwareUpdateRequired(SensorConnection sensorConnection, String s, String s1) {

        }
    };
    @Override
    public void onCrankRevsData(CrankRevs.Data data) {
        DataToSend.sended = false;
        DataToSend.data = data;
    }

    @Override
    public void onSensorConnectionStateChanged(SensorConnection sensorConnection, HardwareConnectorEnums.SensorConnectionState sensorConnectionState) {

    }

    @Override
    public void onSensorConnectionError(SensorConnection sensorConnection, HardwareConnectorEnums.SensorConnectionError sensorConnectionError) {

    }

    @Override
    public void onNewCapabilityDetected(SensorConnection sensorConnection, Capability.CapabilityType capabilityType) {
        if(capabilityType == Capability.CapabilityType.CrankRevs){
            CrankRevs _crankRevs = (CrankRevs)sensorConnection.getCurrentCapability(Capability.CapabilityType.CrankRevs);
            _crankRevs.addListener(this);
            connected = true;
            new TcpListener();
        }
    }

    @Override
    public void onDeviceDiscovered(ConnectionParams connectionParams) {
        mHardwareConnector.requestSensorConnection(connectionParams, this);
        mHardwareConnector.stopDiscovery(HardwareConnectorTypes.NetworkType.BTLE);
    }

    @Override
    public void onDiscoveredDeviceLost(ConnectionParams connectionParams) {

    }

    @Override
    public void onDiscoveredDeviceRssiChanged(ConnectionParams connectionParams, int i) {

    }

}
