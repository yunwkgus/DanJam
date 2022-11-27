//
//  gif.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/02/03.
//

import SwiftUI

struct ContentView1: View{
    var body: some View{
        ZStack{
            Color.blue

            GifImage("cloud-tree").foregroundColor(.clear)
                .frame(width: 200, height: 200)
            
    }
    }
}

struct Gif_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
