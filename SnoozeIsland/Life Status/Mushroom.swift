//
//  Mushroom.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/03.
//

import SwiftUI

struct Mushroom_Detail: View {
    
    @EnvironmentObject var data_Test: Data_Test

    var body: some View {
        
        ZStack{
            GeometryReader { proxy in
                data_Test.day as! Bool ? Image("Day_background") .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(.all) : Image("Night_background") .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 0){


                ZStack(alignment: .center){
                    Image("creature_detail_box").resizable().frame(height: proxy.size.height * 0.6)
                    Image("mushroom1").resizable().frame(width: proxy.size.width * 0.8, height: proxy.size.height * 0.4)
                }
                    Text("Rose mushroom").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).padding(.vertical, proxy.size.height * 0.02)

                    Divider().frame(width: proxy.size.width * 0.8)

                    
                    Text("The head of rose mushroom looks like a rose is hanging upside down. The rose mushroom’s strong fragrant fills the entire island once they bloom. Especially at nighttime, they produce a relaxing mist that aids you to a restful sleep. ").font(Font.custom("AmaticSC-Regular", size:20)).foregroundColor(.white).padding(.all, proxy.size.width * 0.05)

                }.offset(y: 60)
            }.ignoresSafeArea()
        }
    }
}

struct Mushroom_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Mushroom_Detail().environmentObject(Data_Test())
    }
}

