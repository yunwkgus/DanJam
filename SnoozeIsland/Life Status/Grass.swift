//
//  Grass.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/03.
//

import SwiftUI

struct Grass_Detail: View {
    
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
                    Image("grass").resizable().frame(width: proxy.size.width * 0.8, height: proxy.size.height * 0.4)
                }
                    Text("Water drop grass").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).padding(.vertical, proxy.size.height * 0.02)

                    Divider().frame(width: proxy.size.width * 0.8)


                    
                    Text("The water drop grass is a moist grass that blooms water droplets. When the grass catches the wind, they sound like glass beads softly hitting each other. Close your eyes and focus on the sound. You will find your peaceful place.  ").font(Font.custom("AmaticSC-Regular", size:20)).foregroundColor(.white).padding(.all, proxy.size.width * 0.05)
                }.offset(y: 60)
            }.ignoresSafeArea()
        }
    }
}

struct Grass_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Grass_Detail().environmentObject(Data_Test())
    }
}


