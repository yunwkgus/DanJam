//
//  Setting.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/21.
//

import SwiftUI

struct Setting: View {
    
    @EnvironmentObject var data_Test : Data_Test
    @State var tag: String? = nil
    
    @State var music: Bool = UserDefaults.standard.object(forKey: "music") == nil ? true : UserDefaults.standard.bool(forKey: "music")
    @State var ambience: Bool = UserDefaults.standard.object(forKey: "ambience") == nil ? true : UserDefaults.standard.bool(forKey: "ambience")
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    
    @State private var resetAlert = false
    @State private var resetOkAlert = false
    
    


    var body: some View {
        
        
        
        NavigationView{
        ZStack{
            
            Image(data_Test.day ? "Day_background" : "Night_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
            
//            Circle().foregroundColor.

            
            GeometryReader { proxy in

            VStack(spacing: 0){
 
                Text("Setting").font(Font.custom("Amatic-Bold", size:40)).foregroundColor(.white).frame(width: proxy.size.width, height: proxy.size.height/10, alignment: .center).padding(EdgeInsets(top: proxy.size.height/30, leading: 0, bottom: 0, trailing: 0))
                Divider().foregroundColor(.white).frame(width: proxy.size.width * 0.8).padding(EdgeInsets(top: 0, leading: 0, bottom: proxy.size.height * 0.03, trailing: 0))
                
                    VStack(alignment: .leading, spacing: proxy.size.height * 0.02){
                    
//                    ZStack(alignment: .leading){
//                        Text("Bedtime Reminder").foregroundColor(.white).font(.title3)
//                        Toggle("", isOn: $data_Test.bedtime).foregroundColor(.white).toggleStyle(SwitchToggleStyle(tint: .purple))}
            
                    ZStack(alignment: .leading){
                        Text("Ambience Sound").foregroundColor(.white).font(Font.custom("Amatic-Bold", size:30))
                        Toggle("", isOn: $ambience).foregroundColor(.white).toggleStyle(SwitchToggleStyle(tint: .purple))}.onChange(of: ambience){
                            value in
                              if value {
                                  playAmbience(source: "Ambience")
                                  UserDefaults.standard.set(ambience, forKey: "ambience")

                                  
                              }
                              else{
                                  playerA.setVolume(0, fadeDuration : 1.5)
                                  playAmbience(source: "Ambience")
                                  UserDefaults.standard.set(ambience, forKey: "ambience")
                                  
                              }
                          }
                    
                    
                    ZStack(alignment: .leading){
                        Text("Background Music").foregroundColor(.white).font(Font.custom("Amatic-Bold", size:30))
                        Toggle("", isOn: $music).foregroundColor(.white).toggleStyle(SwitchToggleStyle(tint: .purple)).onChange(of: music){
                          value in
                            if value {
                                playSound(day:                                 data_Test.day)

                                UserDefaults.standard.set(music, forKey: "music")
                            }
                            else{
                                player.setVolume(0, fadeDuration : 1.5)
                                UserDefaults.standard.set(music, forKey: "music")
                            }
                        }
                    }
                    
//                    Button( action : {
//                                self.tag = "Language"}){
//                            Text("Change Language").foregroundColor(.white).font(Font.custom("Amatic-Bold", size:30))
//
//                    }
                        
                        Spacer().frame(height: proxy.size.height * 0.1)
                        
                        Button(action: {
                            resetAlert = true
                            print("RESET IS CLICKED")

                        })
                        {
                            
                            Text("Reset")
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: proxy.size.width * 0.8, height: proxy.size.height * 0.08).foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.purple).shadow(radius: 3))

                        }.alert(isPresented: $resetAlert) {
                            
                            Alert(title: Text("Are you sure you want to reset?"), message: Text(" All the creatures on Snooze island would leave and DanJam would forget you."), primaryButton: .destructive(Text("Reset"))
                                  
                                  {

                                
                                data_Test.reset()
                                resetOkAlert = true
                      
                            }, secondaryButton: .cancel())}                                    .alert("The island of Danjam is gone. A new island is created.", isPresented: $resetOkAlert) {
                                Button("OK", role: .cancel) {
                                    // restart application
                                    
                                    
                                }
                            }
                        
                    

                    }.padding(.horizontal, proxy.size.width * 0.1)
            
        }.ignoresSafeArea()
    }
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


struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting().environmentObject(Data_Test())
    }
}


