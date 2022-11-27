//
//  ContentView.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/20.
//

import SwiftUI


// launchScreen

extension ContentView {
    
    
    var launchScreenView: some View {
        
        ZStack(alignment: .center) {
//
//            LinearGradient(gradient: Gradient(colors: [.purple, .white]),
//                            startPoint: .top, endPoint: .bottom)
//            .edgesIgnoringSafeArea(.all)
//
            Color.purple
            
            Text("Jaram+").foregroundColor(.white).font(.custom("Amatic-Bold", size: 80.0))
            

            
        }.ignoresSafeArea()
        
    }
    

    
}

struct ContentView: View {
    @EnvironmentObject var data_Test : Data_Test
    @ObservedObject var bleManager = BLEManager()
    @State var isLoading: Bool = true
    

        
    var body: some View {
        
        ZStack{

        Home().environmentObject(Data_Test())
            .onAppear(perform:{
                playSound(day: UserDefaults.standard.bool(forKey: "day"))
                playAmbience(source: "Ambience")

        })
            
            if isLoading {
                // 2) CHANGED: transition and zIndex added
                launchScreenView.transition(.opacity).zIndex(1)
                

            } 
            
        
            
}.onAppear {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {

        withAnimation { isLoading.toggle() }
    })
    

}
        
      
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

