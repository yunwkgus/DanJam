////
////  Tab.swift
////  SnoozeIsland
////
////  Created by 윤자현 on 2021/12/23.
//
//
//import SwiftUI
//
//struct Tab: View {
//    @EnvironmentObject var data_Test: Data_Test
//    var body: some View {
//
//        NavigationView {
//            ZStack{
//                data_Test.day ? Rectangle().foregroundColor(.purple).frame(width: UIScreen.main.bounds.size.width) : Rectangle().foregroundColor(.blue).frame(width: UIScreen.main.bounds.size.width)
//
//            List{
//                NavigationLink("Main", destination: MainIsland2(x: .constant(CGFloat.zero), wakeupTime: .constant(CGFloat.zero), sleepTime: .constant(CGFloat.zero))).navigationTitle("")
//                    .navigationBarHidden(true)
//                NavigationLink("Life Status", destination: LifeStatus()).navigationTitle("")
//                    .navigationBarHidden(true)
//                    
//                NavigationLink("Sleep Log", destination: SleepLog_Main()).navigationTitle("")
//                    .navigationBarHidden(true)
//                NavigationLink("Mail", destination: MailBox()).navigationTitle("")
//                    .navigationBarHidden(true)
//                NavigationLink("Setting", destination: Setting()).navigationTitle("")
//                    .navigationBarHidden(true)
//                NavigationLink("BlueTooth", destination: BlueTooth(light: "Dallight OFF")).navigationTitle("")
//                    .navigationBarHidden(true)
//                NavigationLink("About Us", destination: AboutUs()).navigationTitle("")
//                    .navigationBarHidden(true)
//
//            }
//        }
//    }
//    }
//}
////
////struct Tab_Previews: PreviewProvider {
////    static var previews: some View {
////        Tab()
////    }
////}
