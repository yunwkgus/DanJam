//
//  Tree.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/03.
//




import SwiftUI

struct Tree_Detail: View {
    
    @EnvironmentObject var data_Test: Data_Test

    var body: some View {
        
        ZStack{
            GeometryReader { proxy in

                data_Test.day as! Bool ? Image("Day_background") .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all) : Image("Night_background") .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(.all)

                
                VStack(alignment: .center, spacing: 0){

                ZStack(alignment: .center){
                    Image("creature_detail_box").resizable().frame(height: proxy.size.height * 0.6)
                    Image("tree").resizable().frame(width: proxy.size.width * 0.9, height: proxy.size.height * 0.5)
                }
                    
                    Text("Cloud Tree").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).padding(.vertical, proxy.size.height * 0.02)

                    Divider().frame(width: proxy.size.width * 0.8)

                    
                    Text("On the cloud tree, clouds bloom as leaves. The cloud tree plays a vital part in helping other island creatures have a good night’s sleep.").font(Font.custom("AmaticSC-Regular", size:20)).foregroundColor(.white).padding(.all, proxy.size.width * 0.05)
             
                }.offset(y: 60)
                }.ignoresSafeArea()
            }
        }
    }

struct Tree_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Tree_Detail().environmentObject(Data_Test())
    }
}

