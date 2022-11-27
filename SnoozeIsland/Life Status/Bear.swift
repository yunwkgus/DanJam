//
//  Bear.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/02.
//


import SwiftUI

struct Bear_Detail: View {
    
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
                    Image("bear").resizable().frame(width: proxy.size.width * 0.75, height: proxy.size.height * 0.45)
                }
                    Text("Star rock bear").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).padding(.vertical, proxy.size.height * 0.02)

                    Divider().frame(width: proxy.size.width * 0.8)


                    
                    Text("The star rock bear is covered with shiny crystal rocks. In contrast to their firm skin and skeleton, their soft fur is fluffy as a blanket of snow. It is well known that they are very social and enjoy the company of other creatures!").font(Font.custom("AmaticSC-Regular", size:20)).foregroundColor(.white).padding(.all, proxy.size.width * 0.05)
                    }.offset(y: 60)
                }.ignoresSafeArea()
            }
        }
    }


struct Bear_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Bear_Detail().environmentObject(Data_Test())
    }
}

