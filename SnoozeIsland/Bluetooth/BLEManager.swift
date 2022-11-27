// bluetooth!

//
//  BLEManager.swift
//  BlueBackground
//
//  Created by 윤자현 on 2022/02/05.
//

import Foundation
import CoreBluetooth


// from Blue StackTree
/// 블루투스와 관련된 일을 전담하는 글로벌 시리얼 핸들러입니다.
var serial : BLEManager!

// 블루투스를 연결하는 과정에서의 시리얼과 뷰의 소통을 위해 필요한 프로토콜입니다.
protocol BluetoothSerialDelegate : AnyObject {
    func serialDidDiscoverPeripheral(peripheral : CBPeripheral, RSSI : NSNumber?)
    func serialDidConnectPeripheral(peripheral : CBPeripheral)
    func serialDidReceiveMessage(message : String)
}

// 프로토콜에 포함되어 있는 일부 함수를 옵셔널로 설정합니다.
extension BluetoothSerialDelegate {
    func serialDidDiscoverPeripheral(peripheral : CBPeripheral, RSSI : NSNumber?) {}
    func serialDidConnectPeripheral(peripheral : CBPeripheral) {}
    func serialDidReceiveMessage(message : String) {}
}

// Blue StackTree Finish


struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let real_peripheral: CBPeripheral
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    public var myCentral: CBCentralManager!
    public var peripheral: CBPeripheral!
    public var connectedPeripheral: CBPeripheral!
    
    
    @Published var isSwitchedOn = false
    @Published var isConnected = false

    @Published var peripherals = [Peripheral]()
    
        override init() {
            super.init()
            myCentral = CBCentralManager(delegate: self, queue: nil)
            myCentral.delegate = self
            
        }
    
    
    //from Blue_StackTree
    
    // BluetoothSerialDelegate 프로토콜에 등록된 메서드를 수행하는 delegate입니다.
    var delegate : BluetoothSerialDelegate?
    
    /// 데이터를 주변기기에 보내기 위한 characteristic을 저장하는 변수입니다.
    weak var writeCharacteristic: CBCharacteristic?
    
    /// 데이터를 주변기기에 보내는 type을 설정합니다. withResponse는 데이터를 보내면 이에 대한 답장이 오는 경우입니다. withoutResponse는 반대로 데이터를 보내도 답장이 오지 않는 경우입니다.
    private var writeType: CBCharacteristicWriteType = .withoutResponse
    
    /// serviceUUID는 Peripheral이 가지고 있는 서비스의 UUID를 뜻합니다. 거의 모든 HM-10모듈이 기본적으로 갖고있는 FFE0으로 설정하였습니다. 하나의 기기는 여러개의 serviceUUID를 가질 수도 있습니다.
    var serviceUUID = CBUUID(string: "FFE0")
    
    /// characteristicUUID는 serviceUUID에 포함되어있습니다. 이를 이용하여 데이터를 송수신합니다. FFE0 서비스가 갖고있는 FFE1로 설정하였습니다. 하나의 service는 여러개의 characteristicUUID를 가질 수 있습니다.
    var characteristicUUID = CBUUID(string : "FFE1")
    
    /// 블루투스 기기와 성공적으로 연결되었고, 통신이 가능한 상태라면 true를 반환합니다.
    var bluetoothIsReady:  Bool  {
        get {
            return myCentral.state == .poweredOn &&
            connectedPeripheral != nil
        }
    }
    
    /// String 형식으로 데이터를 주변기기에 전송합니다.
    func sendMessageToDevice(_ message: String) {
        guard bluetoothIsReady else { return }
        // String을 utf8 형식의 데이터로 변환하여 전송합니다.
//        print(message)
        if let data = message.data(using: String.Encoding.utf8) {
            connectedPeripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
        }
    }
    
        
        
    /// 데이터 Array를 Byte형식으로 주변기기에 전송합니다.
    func sendBytesToDevice(_ bytes: [UInt8]) {
        guard bluetoothIsReady else { return }
        
        let data = Data(bytes: UnsafePointer<UInt8>(bytes), count: bytes.count)
        connectedPeripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
    }
    
    /// 데이터를 주변기기에 전송합니다.
    func sendDataToDevice(_ data: Data) {
        guard bluetoothIsReady else { return }
        
        connectedPeripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
    }
    
    // 기기가 연결되면 호출되는 메서드입니다.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        connectedPeripheral = peripheral
        print("Connected")
        
        if connectedPeripheral != nil {
            isConnected = true}
        
        myCentral.stopScan()
            
        // peripheral의 Service들을 검색합니다.파라미터를 nil으로 설정하면 peripheral의 모든 service를 검색합니다.
        peripheral.discoverServices([serviceUUID])
        

    }
    
    
    // service 검색에 성공 시 호출되는 메서드입니다.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            // 검색된 모든 service에 대해서 characteristic을 검색합니다. 파라미터를 nil로 설정하면 해당 service의 모든 characteristic을 검색합니다.
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
        }
    }
    
    
    // characteristic 검색에 성공 시 호출되는 메서드입니다.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            // 검색된 모든 characteristic에 대해 characteristicUUID를 한번 더 체크하고, 일치한다면 peripheral을 구독하고 통신을 위한 설정을 완료합니다.
            if characteristic.uuid == characteristicUUID {
                // 해당 기기의 데이터를 구독합니다.
                peripheral.setNotifyValue(true, for: characteristic)
                // 데이터를 보내기 위한 characteristic을 저장합니다.
                writeCharacteristic = characteristic
                // 데이터를 보내는 타입을 설정합니다. 이는 주변기기가 어떤 type으로 설정되어 있는지에 따라 변경됩니다.
                writeType = characteristic.properties.contains(.write) ? .withResponse :  .withoutResponse
                // 주변 기기와 연결 완료 시 동작하는 코드를 여기에 작성합니다.
                delegate?.serialDidConnectPeripheral(peripheral: peripheral)
            }
        }
    }
    
    
    // peripheral으로부터 데이터를 전송받으면 호출되는 메서드입니다.
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        // 전송받은 데이터가 존재하는지 확인합니다.
        let data = characteristic.value
        guard data != nil else { return }
        
        // 데이터를 String으로 변환하고, 변환된 값을 파라미터로 한 delegate함수를 호출합니다.
        if let str = String(data: data!, encoding: String.Encoding.utf8) {
            delegate?.serialDidReceiveMessage(message : str)
        } else {
            return
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        // writeType이 .withResponse일 때, 블루투스 기기로부터의 응답이 왔을 때 호출되는 메서드입니다.
        // 필요한 로직을 작성하면 됩니다.
    }
    

    // Blue StackTree finish


    func centralManagerDidUpdateState(_ central: CBCentralManager) {
         if central.state == .poweredOn {
             isSwitchedOn = true
         }
         else {
             isSwitchedOn = false
         }
    }


    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        var peripheralName: String!
       
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = name
        }
        else {
            peripheralName = "Unknown"
        }
       
        let newPeripheral = Peripheral(id: peripherals.count, name: peripheralName, real_peripheral: peripheral)
        
        print(newPeripheral.id," ", newPeripheral.name)
        
        peripherals.append(newPeripheral)
        
//        print("THIS IS EXECUTED")
    
        
        if (newPeripheral.name == "BT-05"){
                self.myCentral.connect(newPeripheral.real_peripheral)
        }
        
    }
    
    
    
    public func startScanning() {
        disconnect()
         print("startScanning")
//        if !isConnected{
         myCentral.scanForPeripherals(withServices: nil, options: nil)
            print("EXECTUED")
//        }
     }
    
    func stopScanning() {
        print("stopScanning")
        myCentral.stopScan()
    }
    
    func reset(){
        peripherals = [Peripheral]()
    }
    
    func disconnect(){
        
        
        stopScanning()
            
        if connectedPeripheral != nil{
            myCentral.cancelPeripheralConnection(connectedPeripheral)
            isConnected = false
            connectedPeripheral = nil
        }
        reset()
            
//        }

    }
    
    

}



