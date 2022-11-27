//
//  Weasel.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/03.
//

import SwiftUI

struct Weasel_Detail: View {
    
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
                    Image("cat").resizable().frame(width: proxy.size.width * 0.5, height: proxy.size.height * 0.4)
                }
                    Text("Three tailed cat").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).padding(.vertical, proxy.size.height * 0.02)

                    Divider().frame(width: proxy.size.width * 0.8)

                    Text("This cat has a tail divided into three parts! It’s named after how the tail looks like a tail of a leaf. Just like all cats, they are cunning and mysterious, but their softly swishing tails creates a mystifying ambience. They do not come down from the cloud tree since they are fond of high places. ").font(Font.custom("AmaticSC-Regular", size:20)).foregroundColor(.white).padding(.horizontal, proxy.size.width * 0.05)

                }.offset(y: 60)
            }.ignoresSafeArea()
        }
    }
}

struct Weasel_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Weasel_Detail().environmentObject(Data_Test())
    }
}



