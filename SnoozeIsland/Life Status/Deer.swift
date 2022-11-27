//
//  Deer.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/03.
//

import SwiftUI

struct Deer_Detail: View {
    
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
                    Image("deer").resizable().frame(width: proxy.size.width * 0.7, height: proxy.size.height * 0.5)
                }
                    Text("O-deer").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).padding(.vertical, proxy.size.height * 0.02)

                    Divider().frame(width: proxy.size.width * 0.8)

                    
                    Text("A white strip starting from its horn ends at the back, creating a cute ‘0’ pattern. Their horns look like two branches facing forward. Their unique striped horns that are connected give off a soft white light.").font(Font.custom("AmaticSC-Regular", size:20)).foregroundColor(.white).padding(.all, proxy.size.width * 0.05)

                }.offset(y: 60)
            }
            .ignoresSafeArea()
        }
    }
}

struct Deer_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Deer_Detail().environmentObject(Data_Test())
    }
}


