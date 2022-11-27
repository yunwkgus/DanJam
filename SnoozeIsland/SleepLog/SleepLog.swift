
//
//  SleepLog.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/29.
//

import SwiftUI


struct SleepLog_Main: View {
    
    @EnvironmentObject var data_Test: Data_Test
    
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        


        NavigationView{
        ZStack{
            
            Image(data_Test.day as! Bool ? "Day_background" : "Night_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))

            
            GeometryReader { proxy in

            VStack(spacing: 0){


                
                Text("Sleep Log").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).frame(width: proxy.size.width, height: proxy.size.height/10, alignment: .center).padding(EdgeInsets(top: proxy.size.height/30, leading: 0, bottom: 0, trailing: 0))
                Divider().foregroundColor(.white).frame(width: proxy.size.width * 0.8).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                VStack(spacing: 40){
                    
            
                    BarChartView(data: ChartData(points: UserDefaults.standard.value(forKey: "sleepFor") as! [Double]? ?? [9.0,8.0,9.0,8.0,7.0,8.5]), title: "Sleep Hour", style: ChartStyle(
                                    backgroundColor: Color.clear,
                                    accentColor: Color.purple,
                                    secondGradientColor: Colors.White,
                                    textColor: Color.white,
                                    legendTextColor: Color.white,
                                    dropShadowColor: Color.white)) // legend is optional

                    LineChartView(data: UserDefaults.standard.value(forKey: "startTime") as! [Double]? ?? [23,23.5,24,25,24.5], title: "Sleep From", style: ChartStyle(
                                        backgroundColor: Color.clear,
                                        accentColor: Color.white,
                                        secondGradientColor: Color.purple,
                                        textColor: Color.white,
                                        legendTextColor: Colors.LightPurple,
                                        dropShadowColor: Color.white))

                }.offset(y:30)
            }
            }
        }.ignoresSafeArea()
        
        }  .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 20 &&
                           value.translation.width > 100) {
                    
                    presentationMode.wrappedValue.dismiss()
                    
                
                }
           }))
            .navigationBarHidden(true)
    }
}

struct SleepLog_Main_Previews: PreviewProvider {
    static var previews: some View {
        SleepLog_Main().environmentObject(Data_Test())
    }
}
