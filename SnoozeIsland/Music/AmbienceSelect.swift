//
//  AmbienceSelect.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/03/01.
//

import SwiftUI

struct AmbienceSelect: View {
//    @EnvironmentObject var data_Test: Data_Test

    var body: some View {
        
        ZStack{
            
//            Image(data_Test.day ? "Day_background" : "Night_background")
            Image("Day_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
            
            
            VStack{
                Button(action: {
                
                    playAmbience(source: "Ambience")
                
                }){
                    
                    ZStack{
                        
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100).foregroundColor(Color.purple).opacity(0.8)
                
                        Image(systemName: "moon").foregroundColor(.white)
                
                }
                    
                }
                
                Button(action: {
                
                    playAmbience(source: "Ambience")
                
                }){
                    
                    ZStack{
                        
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100).foregroundColor(Color.purple).opacity(0.8)
                
                        Image(systemName: "heart.fill").foregroundColor(.white)
                
                }
                    
                }
                
                
            }

        }
        
        
    }
}

struct AmbienceSelect_Previews: PreviewProvider {
    static var previews: some View {
        AmbienceSelect()
    }
}
