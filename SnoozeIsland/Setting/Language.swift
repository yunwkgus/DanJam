//
//  Language.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/20.
//

import SwiftUI

struct Language: View {
    var body: some View {
        
        ZStack{
            Image("Night_background")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
            
                
                Text("Change Language").foregroundColor(.white)
                
            }

        }
    }
}

struct Language_Previews: PreviewProvider {
    static var previews: some View {
        Language()
    }
}
