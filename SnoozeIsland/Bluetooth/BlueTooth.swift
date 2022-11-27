//
//  ContentView.swift
//  BlueBackground
//
//  Created by 윤자현 on 2022/02/05.
//
import SwiftUI
import UserNotifications


struct BlueTooth: View {
    
    @EnvironmentObject var data_Test: Data_Test
    
    @State private var on = false
//    @State private var connected = false
    @State private var wakeUp = Date()
    @State private var curTime = Date()
    @State public var light: String
    @State private var saved: String = ""

    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        ZStack{
            
            Image(data_Test.day as! Bool ? "Day_background" : "Night_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))

            
            GeometryReader { proxy in

            VStack(spacing: 0){
 
                Text("DALLIGHT").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).frame(width: proxy.size.width, height: proxy.size.height/10, alignment: .center).padding(EdgeInsets(top: proxy.size.height/30, leading: 0, bottom: 0, trailing: 0))
                
                Divider().foregroundColor(.white).frame(width: proxy.size.width * 0.8).padding(EdgeInsets(top: 0, leading: 0, bottom: proxy.size.height * 0.03, trailing: 0))
        
            
        VStack (spacing: 5) {
 
//
//            Spacer()
//            Text("Bluetooth Devices")
//                .font(.largeTitle).foregroundColor(.white)
//                .frame(maxWidth: .infinity, alignment: .center)
//            List(data_Test.bleManager.peripherals) { peripheral in
//                HStack {
//                    Button(action: {
//                        data_Test.bleManager.myCentral.connect(peripheral.real_peripheral)
//
//                    }){
//                        HStack{
//                        Text(peripheral.name ?? "")
//                        Spacer()
//
//                        }
//                    }
//                    Spacer()
//                }
//            }.frame(height: 300)
            

            Toggle(isOn: $data_Test.bleManager.isConnected){
                Text("With my Dallight").foregroundColor(.white).padding().font(Font.custom("Amatic-Bold", size:25))
            }.onChange(of: data_Test.bleManager.isConnected){
                value in
                if value{
                    data_Test.bleManager.startScanning()
                    print("Start Scanning!")
                }
                else {
                    light = "LIGHT OFF"
                    data_Test.bleManager.sendMessageToDevice("off")
                    data_Test.bleManager.disconnect()
                    
                }
            }.padding()
            
//               Button(action: {
//                   data_Test.bleManager.startScanning()
//               }) {
//
//                   ZStack{
//                       RoundedRectangle(cornerRadius: 20).frame(width: 80, height: 30, alignment: .center).foregroundColor(.purple)
//                       if connected{
//
//                       Text("Connected").foregroundColor(.white)
//                       }
//                       else {
//                           Text("Connect").foregroundColor(.white)
//                       }
//                   }
//               }
            

            
            Toggle(isOn: $on){
                
                Text("\(light)").foregroundColor(.white).padding().font(Font.custom("Amatic-Bold", size:25))
            }.onChange(of: self.on) {
                value in
                if value {
                    
                    if data_Test.day {
                        data_Test.bleManager.sendMessageToDevice("day")

                    } else {
                        data_Test.bleManager.sendMessageToDevice("night")

                    }
                    
                    light = "LIGHT ON"
                }
                else {
                    light = "LIGHT OFF"
                    data_Test.bleManager.sendMessageToDevice("off")
                }
            }.padding().disabled( data_Test.bleManager.isConnected ? false : true)


//
//                VStack (spacing: 10) {
//                    Button(action: {
//                        print("DisConnect")
//                        data_Test.bleManager.disconnect()
//                        // 동작 필요
//                    }) {
//                        Text("DisConnect")
//                    }
//
//                }.padding()
//            }
            
            
            VStack(alignment: .leading){
                
                DatePicker(selection: $wakeUp, in: Date()..., displayedComponents: .hourAndMinute) {
                Text("Alarm Setting").foregroundColor(.white).padding().font(Font.custom("Amatic-Bold", size:25))
                
            }
                if saved == "" {
                    Text("No Alarm").font(Font.custom("Amatic-Bold", size:20)).foregroundColor(.white).padding().offset(y:-15)
                }
                else{
                    Text("Saved on:  \(saved)").font(Font.custom("Amatic-Bold", size:20)).foregroundColor(.white).padding().offset(y:-15)
                }
                
                

                        
            }.padding()
       
        }
                
                
                Button(action: {

                    
                    data_Test.bleManager.sendMessageToDevice(DateType2String(date: wakeUp)+":timeJram")
                    saved = DateType2String(date:wakeUp)
                    
                    print("save")
                    
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 80, height: 30, alignment: .center).foregroundColor(.purple)
                        Text("Save").foregroundColor(.white).font(Font.custom("Amatic-Bold", size:20))
                        
                    }

                }
                
                
    }
}
        }
        .ignoresSafeArea()
        
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 20 &&
                       value.translation.width > 100) {
                
                presentationMode.wrappedValue.dismiss()
                
            
            }
       }))
        .navigationBarHidden(true)
    }}
    
 
struct BlueTooth_Previews: PreviewProvider {
    static var previews: some View {
        BlueTooth(light: "LIGHT OFF").environmentObject(Data_Test())
    }
}


func DateType2String(date: Date) -> String{
    let current = date
    
    let formatter = DateFormatter()
    //한국 시간으로 표시
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.timeZone = TimeZone(abbreviation: "KST")
    //형태 변환
    formatter.dateFormat = "HH:mm"
    
    return formatter.string(from: current)
}


func String2DateType(string : String) -> Date{
    let formatter = DateFormatter()
    
    formatter.dateFormat = "HH:mm"
    
    return formatter.date(from: string)!
}

