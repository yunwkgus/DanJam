//
//  SetTime.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/02/08.
//

import SwiftUI

//class tiemValue {
//
//
//}


struct TimeCycleView: View {
    
    
    @EnvironmentObject var data_Test: Data_Test
//    @State var wakeupAngleValue: CGFloat = 15 * CGFloat(UserDefaults.standard.float(forKey: "wakeTime"))

//    @State var sleepAngleValue: CGFloat = 15 * CGFloat(UserDefaults.standard.float(forKey: "sleepTime"))
    
    @State var clicked : Bool = false
    @State var cycleAlert : Bool = false

    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    
    let wakeup_config = Config(minimumValue: 0.0,
                        maximumValue: 24.0,
                        totalValue: 24.0,
                        knobRadius: 15.0,
                        radius: 125.0)
    let sleep_config = Config(minimumValue: 0.0,
                        maximumValue: 24.0,
                        totalValue: 24.0,
                        knobRadius: 15.0,
                        radius: 125.0)
    
    var body: some View {
        NavigationView {

            
            ZStack{
                
                Image(data_Test.day ? "Day_background" : "Night_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                
                GeometryReader { proxy in

                VStack(spacing: 0){
                    
                    VStack(spacing: 0){
         
                        Text("Sleep Time").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).frame(width: proxy.size.width, height: proxy.size.height/10, alignment: .center).padding(EdgeInsets(top: proxy.size.height/30, leading: 0, bottom: 0, trailing: 0))
                        Divider().foregroundColor(.white).frame(width: proxy.size.width * 0.8).padding(EdgeInsets(top: 0, leading: 0, bottom: proxy.size.height * 0.03, trailing: 0))
                        
                        Spacer().frame(width: proxy.size.width, height: proxy.size.height/10, alignment: .center)
                        
                        
                        VStack(spacing: 0){
                    ZStack{
                        Circle()
                            .fill(Color.white)
                            .frame(width: wakeup_config.radius * 2.3, height: wakeup_config.radius * 2.3)
                            .opacity(0.15)
                            .scaleEffect(1.2).shadow(color: .white, radius: 5)
                        
//                        Circle()
//                            .stroke(Color.gray,
//                                    style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [3, 23.18]))
//                            .frame(width: wakeup_config.radius * 2, height: wakeup_config.radius * 2)
                        


                        
                        
                        
//                        if( sleepTimeValue/sleep_config.totalValue < 1){
                        
                        Circle()
//                            .trim(from: sleepTimeValue/sleep_config.totalValue, to: sleepTimeValue/sleep_config.totalValue > 0 ? 24.0 : wakeupTimeValue/wakeup_config.totalValue)
                        .stroke(Color.purple, lineWidth: 6)
                        .frame(width: wakeup_config.radius * 2.2, height: wakeup_config.radius * 2.2)
                        .rotationEffect(.degrees(-90)).shadow(color: .white, radius: 3)
//                        }
                        
//                        Circle()
//                            .trim(from:
//                                    sleepTimeValue/sleep_config.totalValue > 0 ? sleepTimeValue/sleep_config.totalValue : 0.0, to: wakeupTimeValue/wakeup_config.totalValue)
//                            .stroke(Color.white.opacity(0.9), lineWidth: 6)
//                            .frame(width: wakeup_config.radius * 2.2, height: wakeup_config.radius * 2.2)
//                            .rotationEffect(.degrees(-90))
//
//

//
                        
                        RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: sleep_config.knobRadius * 1.2, height: sleep_config.knobRadius * 1)
                                .padding(10)
                                .offset(y: -wakeup_config.radius * 1.1)
                                .rotationEffect(Angle.degrees(Double(data_Test.sleepAngleValue)))
                                .gesture(DragGesture(minimumDistance: 0.0)
                                            .onChanged({ value in
                                                sleep_change(location: value.location)
                                            })).shadow(color: .white, radius: 5)
                        
                            
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: wakeup_config.knobRadius * 1.2, height: wakeup_config.knobRadius * 1)
                            .padding(10)
                            .offset(y: -wakeup_config.radius * 1.1)
                            .rotationEffect(Angle.degrees(Double(data_Test.wakeupAngleValue)))
                            .gesture(DragGesture(minimumDistance: 0.0)
                                        .onChanged({ value in
                                            wakeup_change(location: value.location)
                                        })).shadow(color: .white, radius: 5)
//
//                        Text("\(String.init(format: "%.0f", sleepTimeValue as CVarArg)):00-"+"\(String.init(format: "%.0f", wakeupTimeValue as CVarArg)):00")
//                            .font(Font.custom("Amatic-Bold", size:50))
//                                            .foregroundColor(.white)
                        

                        Text("\(String.init(format: "%.0f", floor(data_Test.changegoalTime) as CVarArg)):00-"+"\(String.init(format: "%.0f", floor(data_Test.changewakeTime) as CVarArg)):00")
                            .font(Font.custom("Amatic-Bold", size:50))
                                            .foregroundColor(.white)
                            

                        
                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: proxy.size.height * 0.07, trailing: 0))
                            
                    
                    Text("Click Button to Save your Cycle ").foregroundColor(.white).font(Font.custom("AmaticSC-Regular", size:30))
                            
//                            Text("\(String.init(format: "%.0f", UserDefaults.standard.float(forKey: "sleepTime")as CVarArg)):00-"+"\(String.init(format: "%.0f", UserDefaults.standard.float(forKey: "wakeTime")as CVarArg)):00")
//                                .font(Font.custom("Amatic-Bold", size:30))
//                                .foregroundColor(.white).shadow(color: .white, radius: 3)
                                
                            Spacer().frame(width: proxy.size.width * 0.1, height: proxy.size.height * 0.05)
                                
                                Button(action:{
                                    
                                    data_Test.saveButton()
                                    cycleAlert = true
                                    
                                })
                            
                                { // button action
                                    
                                        
                                    Text("Save")
                                        .fixedSize(horizontal: true, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: proxy.size.width * 0.8, height: proxy.size.height * 0.07).foregroundColor(.white)
                                        .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.purple).shadow(radius: 3))
                                    
                            }.alert("Your Time Cycle is now " + "\(String.init(format: "%.0f", floor(data_Test.changegoalTime) as CVarArg)):00-"+"\(String.init(format: "%.0f", floor(data_Test.changewakeTime) as CVarArg)):00.", isPresented: $cycleAlert) {
                                Button("OK", role: .cancel) {
                                    // restart application
                                    
                                }
                                
                            } // button action end
                                
                            
                        }.offset(y: -proxy.size.height * 0.05)
                    } // clock zstack
                    
          
                
            }
            
        }.ignoresSafeArea()

    }
            
    }        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        if(value.startLocation.x < 20 &&
                   value.translation.width > 100) {
            
            presentationMode.wrappedValue.dismiss()
            
        
        }
   }))
    .navigationBarHidden(true)

    }
    
    
    private func sleep_change(location: CGPoint) {
        // creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
        
        // geting angle in radian need to subtract the knob radius and padding from the dy and dx
        let angle = atan2(vector.dy - (sleep_config.knobRadius + 10), vector.dx - (sleep_config.knobRadius + 10)) + .pi/2.0
        
        // convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // convert angle value to temperature value
        let value = fixedAngle / (2.0 * .pi) * sleep_config.totalValue
        
        if value >= sleep_config.minimumValue && value <= sleep_config.maximumValue {
            data_Test.changegoalTime = Float(value)
            
            data_Test.sleepAngleValue = CGFloat(fixedAngle * 180 / .pi) // converting to degree
        }
    }
    
    private func wakeup_change(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: location.y)

        let angle = atan2(vector.dy - (wakeup_config.knobRadius + 10), vector.dx - (wakeup_config.knobRadius + 10)) + .pi/2.0
        
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // convert angle value to temperature value
        let value = fixedAngle / (2.0 * .pi) * wakeup_config.totalValue
        
        if value >= wakeup_config.minimumValue && value <= wakeup_config.maximumValue {
            data_Test.changewakeTime = Float(value)
            data_Test.wakeupAngleValue = CGFloat(fixedAngle * 180 / .pi) // converting to degree
        }
    }
}

struct Config {
    let minimumValue: CGFloat
    let maximumValue: CGFloat
    let totalValue: CGFloat
    let knobRadius: CGFloat
    let radius: CGFloat
}

struct TutorialView_2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimeCycleView().environmentObject(Data_Test())
                .previewDevice("iPhone 8")
           
        }
    }
}
