//
//  AboutUs.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/28.
//

import SwiftUI

struct AboutUs: View {
    @EnvironmentObject var data_Test: Data_Test
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    

    var body: some View {
        
        
        ZStack{
            
            Image(data_Test.day as! Bool ? "Day_background" : "Night_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))

            
            GeometryReader { proxy in

            VStack(spacing: 0){
 
                
                
                Text("About Us").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).frame(width: proxy.size.width, height: proxy.size.height/10, alignment: .center).padding(EdgeInsets(top: proxy.size.height/30, leading: 0, bottom: 0, trailing: 0))
                Divider().foregroundColor(.white).frame(width: proxy.size.width * 0.8).padding(EdgeInsets(top: 0, leading: 0, bottom: proxy.size.height * 0.02, trailing: 0))
                
                
                ZStack{

                    Text("Good day and Good night! We are Jaram +. Hope you Enjoy your wonderful lifes with NAME.\n\nWe start from  in Seoul National University, supported by UROP in Collge of Liberal Arts.\n\nMake your life more healthier by maintaining regular sleep!").font(Font.custom("AmaticSC-Regular", size:30)).multilineTextAlignment(.leading).foregroundColor(.white).frame(width: proxy.size.width*0.7, height: proxy.size.height*0.7, alignment: .topLeading).animation(Animation.easeIn(duration: 1))
   
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white).opacity(0.5).frame(width: proxy.size.width*0.8, height: proxy.size.height*0.75, alignment: .center)
                   }.padding(.horizontal, proxy.size.width * 0.1)

                
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
}

struct AboutUS_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs().environmentObject(Data_Test())
    }
}
