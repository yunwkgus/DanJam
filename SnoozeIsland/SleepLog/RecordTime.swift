////
////  RecordTime.swift
////  SnoozeIsland
////
////  Created by 윤자현 on 2022/01/05.
////
//
//import SwiftUI
//
//struct RecordTime: View {
//    
//    
//    @State private var time: Double = 120.3
////    private var start: Date
////    private var end: Date
//    var timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect()
//    @State private var isStart = false
//
//
//    
//    var body: some View {
//        
//        
//
//        VStack{
//        SecCount(sec: time).offset(y:50).onReceive(timer, perform: { _ in
//            withAnimation{
//                if isStart{
//            self.time += 0.1
////                var start = Date()
//                }
//                
//                else{
//                    self.time += 0.5
////                var end = Date()
//                }
//            }
//            })
//            
////            Text("\(start)")
////            Text("\(end)")
////            Text("\(start.timeIntervalSince(end))")
////             
//        StartStopButton(isStart: $isStart)
//        }
//        
//
//    }
//}
//
//
////            let date = Date()
////            var calendar = Calendar.current
////
////            let hour = calendar.component(.hour, from: date)
////            let minute = calendar.component(.minute, from: date)
////            var starting = Date()
////            var end = Date()
//
//
//struct SecCount: View{
//    var sec: Double
//    private var height: CGFloat = 25
//    init(sec: Double){
//        self.sec = sec
//    }
//
//    var body: some View{
//        Rectangle()
//            .fill(Color.gray)
//            .frame(width: 2, height: height)
//            .offset(y: -height / 2)
//            .rotationEffect(.degrees( sec / 60 * 60 * 360))
//    }
//}
//
//
//
//
//struct StartStopButton: View{
//    @Binding var isStart: Bool
//    var body: some View {
//        HStack{
//            Button(action: { isStart = true}
//                   , label: {
//              Text("Start").frame(width:UIScreen.main.bounds.size.width / 2 , height:50).background(Color.orange)
//            })
//
//            Button(action: { isStart = false            }
//                   , label: {
//              Text("Stop").frame(width:UIScreen.main.bounds.size.width / 2 , height:50).background(Color.orange)
//            })
//        }
//    }
//}
//
//struct RecordTime_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordTime()
//    }
//}
//
//
//
//
//
