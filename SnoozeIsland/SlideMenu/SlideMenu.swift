//
//  SlideMenu.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/23.
//

import SwiftUI



struct Home: View{
    
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = UIScreen.main.bounds.width + 90
    @EnvironmentObject var data_Test : Data_Test

    
    var body: some View{
        
        NavigationView{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            
//            HomePage(x: $x)


                    
            MainIsland2(x: .constant(CGFloat(22.00)), wakeupTime: .constant(CGFloat(UserDefaults.standard.float(forKey: "wakeTime"))), sleepTime: .constant(CGFloat(UserDefaults.standard.float(forKey: "sleepTime"))))
            
            
            SlideMenu().shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y : 0).offset(x: x).background(Color.black.opacity(x == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical).onTapGesture{
                
                withAnimation{
                    x = -width
                }
            })
            
            
        }
        .gesture(DragGesture().onChanged({ (value) in
            withAnimation{
                if value.translation.width > 0 {

                    if x < 0 {
                        
                        x = -width + value.translation.width
                    }
                }
                else{
                    x = value.translation.width
                }
            }
            
        }).onEnded({ (value) in
            withAnimation{
                
                if -x < width / 2 {
                    x = 0
                }else{
                    
                    x = -width
                }
                
                
            }
            
        }))
        
    }
    }
    
}


struct SlideMenu: View {


    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var show = true
    
//    init(){
//        let myAppearance = UINavigationBarAppearance()
//        myAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Font.custom("Amatic-Bold", size:30)]
//
//        myAppearance.backgroundColor = .clear
//
//        UINavigationBar.appearance().standardAppearance = myAppearance
//
//        UINavigationBar.appearance().compactAppearance = myAppearance
//
//    UINavigationBar.appearance().tintColor = .white
//
//    }

    @EnvironmentObject var data_Test : Data_Test

    
    
    var body: some View {
        
        
        HStack(spacing: 0){
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    
                    Spacer()

                    VStack(alignment: .leading){
                    
                        VStack(alignment: .leading){
                            NavigationLink("Life Status", destination: LifeStatus()).font(Font.custom("Amatic-Bold", size:30))
                                .foregroundColor(Color.white)
                            Divider().padding(.vertical, 10)
                        }

                        VStack(alignment: .leading){
                    NavigationLink("Sleep Log", destination: SleepLog_Main()).navigationTitle("").font(Font.custom("Amatic-Bold", size:30))
                        .navigationBarHidden(true).foregroundColor(Color.white)
                        Divider().padding(.vertical, 10)
                        }
                        
    
                        
                        NavigationLink("Cycle", destination: TimeCycleView()).navigationTitle("").font(Font.custom("Amatic-Bold", size:30))
                            .navigationBarHidden(true).foregroundColor(Color.white).onAppear(perform: {data_Test.loadTime()})
//
//                        NavigationLink("Cycle", destination: TimeCycleView()).navigationTitle("").font(Font.custom("Amatic-Bold", size:30))
//                                .navigationBarHidden(true).foregroundColor(Color.white)
//
//
                                
                        Divider().padding(.vertical, 10)

                    NavigationLink("Setting", destination: Setting()).navigationTitle("")
                            .font(Font.custom("Amatic-Bold", size:30)).navigationBarHidden(true).foregroundColor(Color.white)
                        Divider().padding(.vertical, 10)
                        
                        NavigationLink("DALLIGHT", destination: BlueTooth(light: "Dallight OFF")).navigationTitle("").font(Font.custom("Amatic-Bold", size:30))
                            .navigationBarHidden(true).foregroundColor(Color.white)
                            Divider().padding(.vertical, 10)

                    NavigationLink("About Us", destination: AboutUs()).navigationTitle("").font(Font.custom("Amatic-Bold", size:30))
                        .navigationBarHidden(true).foregroundColor(Color.white)
                        Divider().padding(.vertical, 10)

                    }
 
                }.opacity(show ? 1 : 0)
                    .frame(height: show ? nil : 0)
     
                Spacer(minLength: 0)
                
                
            }
            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges? .top)
            .padding(.bottom, edges!.bottom == 0 ? 15 : edges? .bottom)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 90)
            .background(Colors.DarkPurple)
            .ignoresSafeArea(.all, edges: .vertical)
            
            Spacer(minLength: 0)
        
        }
    }
}


struct FollowView: View {
    
    var count: Int
    var title: String
    
    var body: some View{
        HStack{
            Text("\(count)")
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(title)
                .foregroundColor(.gray)
            
        }
    }
    
}


var menuButtons = ["Life Status", "Sleep Log", "Mail Box", "Setting", "About Us"]


struct MenuButton: View {
    
    var title: String
    
    var body: some View {
        
        HStack(spacing: 15){
            
            Image(title).resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            
            Text(title).foregroundColor(.black)
            
            Spacer(minLength: 0)
            
        }.padding(.vertical, 12)
    }
}




struct ContentView1_Previews: PreviewProvider {
    @EnvironmentObject var data_Test : Data_Test
    


    static var previews: some View {
        Home().environmentObject(Data_Test())
    }
}
