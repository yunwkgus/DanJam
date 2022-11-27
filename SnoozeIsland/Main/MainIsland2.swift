//
//  MainIsland2.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/30.
//

import SwiftUI
import AVKit
import SpriteKit
//import Gifu

struct MainIsland2: View {
     
    @EnvironmentObject var data_Test: Data_Test

    
    @Binding var x : CGFloat
    
    @State private var daycount = 1.0
    @State private var start = 0
    @State private var end = 0.0
    
    @State private var tutorialCount = 0
    

    @State private var showingAlert = false
    
    @Binding var wakeupTime: CGFloat
    @Binding var sleepTime: CGFloat
    

    var body: some View {
        GeometryReader { proxy in
            
            ZStack{
                
                
                Image(data_Test.day ? "Day_background" : "Night_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                
                if(data_Test.day == false){

                    SpriteView(scene: StarShine(), options: [.allowsTransparency])
                } else {
                    SpriteView(scene:CloudMove(), options: [.allowsTransparency])
                }
                

                
                VStack( alignment: .center, spacing: 0){
                    
//                    Text("\(data_Test.consistency)")
                    
                    Button(action: {
                        showingAlert = true
                        
                    }, label: {
                        
                        
                        Image(data_Test.day ? "sun" : "moon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width*0.4, height: proxy.size.height*0.4, alignment: .center)
                          
                    }).offset(x: -proxy.size.width * 0.25)
                        
                    
                        .alert(isPresented: $showingAlert) {
                            data_Test.day ?
                            Alert(title: Text("Do you want to sleep now?"),
                                  primaryButton: .default(Text("Yes")) {
                            action: do {
                                data_Test.day = false
                                UserDefaults.standard.set(data_Test.day, forKey: "day")
//                                wakeupExactTime() ? (daycount += 0.5) : (daycount -= 0.0)
                                if wakeupExactTime()
                                {data_Test.bedtime = true
                                    UserDefaults.standard.set(true, forKey : "bedTime")
                                }
                                else{
                                    data_Test.bedtime = false
                                    UserDefaults.standard.set(false, forKey : "bedTime")
                                }
                                
                                data_Test.startadd(time: Date())
                                
                                let date = Date()
                                let calendar = Calendar.current
                                let components = calendar.dateComponents([.day, .hour, .minute], from: date)
                                
                                UserDefaults.standard.set(components.day, forKey: "startDay")
                                UserDefaults.standard.set(components.hour, forKey: "startHour")
                                UserDefaults.standard.set(components.minute, forKey: "startMinute")
                                
//                                startday = components.day!
//                                starthour = components.hour!
//                                startminute = components.minute!
                                                                
                                
                                if data_Test.music  as! Bool{
                                    player.setVolume(0, fadeDuration : 1.5)
                                    playSound(day: data_Test.day)
                                }
                                if data_Test.bleManager.isConnected{

                                data_Test.bleManager.sendMessageToDevice("night")
                                }
                                
                                
                            }},
                                  secondaryButton: .cancel()) :
                            Alert(title: Text("Do you want to wake up now?"),
                                  primaryButton: .default(Text("Yes")) {
                            action: do {
                                data_Test.day = true
                                UserDefaults.standard.set(data_Test.day, forKey: "day")
//
//                                sleepExactTime() ? (daycount += 1.0) : (daycount -= 1.0)

                                let date = Date()
                                let calendar = Calendar.current
                                let components = calendar.dateComponents([.day, .hour, .minute], from: date)
                                var endday = components.day!
                                var endhour = components.hour!
                                var endminute = components.minute!
                                                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "dd HH:mm"
                                
                                let startDate = dateFormatter.date(from:"\(UserDefaults.standard.integer(forKey:"startDay")) \(UserDefaults.standard.integer(forKey:"startHour")):\(UserDefaults.standard.integer(forKey:"startMinute"))")!
                                let endDate = dateFormatter.date(from:"\(endday) \(endhour):\(endminute)")!

                                let interval = endDate.timeIntervalSince(startDate)
                                let hours = Double(interval / 3600)
                                data_Test.foradd(time: round(hours*10) / 10)
 
                                if data_Test.music as! Bool{
                                    player.setVolume(0, fadeDuration : 1.5)
                                    playSound(day: data_Test.day)
                                }
                                if data_Test.bleManager.isConnected{
                                data_Test.bleManager.sendMessageToDevice("day")
                                }

                                
                            }},
                                  secondaryButton: .cancel())
                        }
                    
                    
                    ZStack{
                        
                        
                        Image("island")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                            .frame(width: proxy.size.width * 0.55, height: proxy.size.height*0.55, alignment: .center)
                                                
                            
                        // consistency is updated at night,
                        
                        let isTree = data_Test.consistency >= 1
                        let isWeasle = data_Test.consistency >= 2
                        let isMushroom = data_Test.consistency >= 3
                        let isBear = data_Test.consistency >= 4
                        let isGrass = data_Test.consistency >= 5
                        let isDeer = data_Test.consistency >= 6

//
//
//                        if isTree {
//
//
//
//                            Image("tree").resizable()                            .frame(width: proxy.size.width * 0.7, height: proxy.size.height*0.4, alignment: .center).offset(x: 50, y: -215)
//
//
//                        }
//
//
//                        if isDeer {
//
//                            if data_Test.day {
//
//                            Image("deer").resizable()                            .frame(width: proxy.size.width * 0.3, height: proxy.size.height*0.25, alignment: .center).offset(x: 90, y: -120)
//                            } else {
//
//                                Image("deer_sleep").resizable()                            .frame(width: proxy.size.width * 0.27, height: proxy.size.height*0.22, alignment: .center).offset(x: 90, y: -80)
//
//                            }
//
//
//
//                        }
//
//
//                        if isWeasle {
//
//                            if data_Test.day {
//                            Image("cat").resizable()                            .frame(width: proxy.size.width * 0.15, height: proxy.size.height*0.13, alignment: .center).offset(x: 40, y: -275)
//                            } else {
//                                Image("cat_sleep").resizable()                            .frame(width: proxy.size.width * 0.19, height: proxy.size.height*0.1, alignment: .center).offset(x: 33, y: -233)
//                            }
//
//
//                        }
//
//                        if isMushroom {
//
//                            Image("mushroom1").resizable()                            .frame(width: proxy.size.width * 0.35, height: proxy.size.height*0.15, alignment: .center).offset(x: -90, y: -140)
//
//                        }
//
//                        if isBear {
//
//                            if data_Test.day {
//
//
//                            Image("bear").resizable()                            .frame(width: proxy.size.width * 0.3, height: proxy.size.height*0.2, alignment: .center).offset(x: -90, y: -80)
//
//                            } else {
//
//                                Image("bear_sleep").resizable()                            .frame(width: proxy.size.width * 0.25, height: proxy.size.height*0.13, alignment: .center).offset(x: -90, y: -60)
//
//
//                            }
//
//
//
//                        }
//
//
//
//                        if isMushroom {
//
//                            Image("mushroom2").resizable()                            .frame(width: proxy.size.width * 0.25, height: proxy.size.height*0.08, alignment: .center).offset(x: -45, y: -10)
//
//                        }
//
//
//
//                        if isGrass {
//
//                            Image("grass").resizable()                            .frame(width: proxy.size.width * 0.4, height: proxy.size.height*0.2, alignment: .center).offset(x: 60, y: -50)
//
//
//                        }
                        


                        
                        
//                        if isTree {
//                            GifImage("cloud-tree")
//                            .frame(width: proxy.size.width*0.7, height: proxy.size.height*0.5).offset(x: proxy.size.width*0.1, y: -proxy.size.height*0.15)}

//                        if isWeasle{
//                            if data_Test.day{
//                            GifImage("weasel")
//                                .frame(width: proxy.size.width*0.25, height: proxy.size.height*0.2).offset(x: proxy.size.width*0.05, y: -proxy.size.height*0.25)}
//                        else {
//                            Image("weasel sleep").resizable()                                .aspectRatio(contentMode: .fill)
//                                .frame(width: proxy.size.width*0.18, height: proxy.size.height*0.13).offset(x: proxy.size.width * 0.05, y: -proxy.size.height*0.27)
//                        }
//                        }

//
//                        if isMushroom{
//                        GifImage("rose-mushroom-group1")
//                            .frame(width: proxy.size.width*0.2, height: proxy.size.height*0.1).offset(x: -proxy.size.width*0.3, y: -proxy.size.height*0.13)
//                        }
//                        
                        GIFView(type: .name("rose-mushroom-group1"))
                          .frame(maxHeight: 300)
                          .padding()

//
//
//
//                        if isBear{
//                            if data_Test.day{
//                            GifImage("bear-day" )
//                                .frame(width: proxy.size.width*0.4, height: proxy.size.height*0.5).offset(x: -proxy.size.width*0.18, y:proxy.size.height*0.07)}
//                            else {
//                                GifImage("bear-night")
//                                    .frame(width: proxy.size.width*0.35, height: proxy.size.height*0.35).offset(x: -proxy.size.width*0.18, y:-proxy.size.height*0.055)
//                            }
//
//                        }
//
//                        if isGrass{
//                            GifImage("waterdrop-grass-group")
//                                .frame(width: proxy.size.width*0.22, height: proxy.size.height*0.11).offset(x: proxy.size.width*0.27, y: -proxy.size.height*0.15)
//
//                        }
//
//                        if isGrass{
//                            GifImage("waterdrop-grass-group")
//                                .frame(width: proxy.size.width*0.22, height: proxy.size.height*0.13).offset(x: proxy.size.width*0.3, y: -proxy.size.height*0.13)
//
//                        }
//
//                        if isDeer {
//                            if data_Test.day{
//                            GifImage("deer-day")
//                                .frame(width: proxy.size.width*0.45, height: proxy.size.height*0.35).offset(x: proxy.size.width*0.15, y: -proxy.size.height*0.08)}
//                            else {
//                                GifImage("deer-night").frame(width: proxy.size.width*0.35, height: proxy.size.height*0.3).offset(x: proxy.size.width*0.2, y: -proxy.size.height*0.06)
//                            }
//                        }

                        
                        

//
//                        if data_Test.day {
//
//
//                            GifImage((data_Test.bedtime ? "danzam_pleased" : "danzam_tired" ))                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .ignoresSafeArea()
//                                .frame(width: proxy.size.width*0.1, height: proxy.size.height * 0.2, alignment: .center).offset(y:-proxy.size.height*0.25)
//
//                        } else {
//
//                        Image("danzam-night")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .ignoresSafeArea()
//                                .frame(width: proxy.size.width*0.1, height: proxy.size.height * 0.18, alignment: .center).offset(y:-proxy.size.height*0.17)
//
//                        }

//                        Text(data_Test.consistency.description)
                        
                    }
//                    .offset(y: -proxy.size.height * 0.08)


                }
                
                // tutorial code
            
//                if data_Test.tutorial == false {
//
//                    ZStack{
//
//                        Color.purple
//
//
//                        // last started : n,
//                        // after n + 1, button and all things disappear
//
//                        if(tutorialCount == 0){
//                            Image("man")}
//                        else if (tutorialCount == 1) {
//                            Image("man sad")}
//
//                        else if (tutorialCount == 2){
//                            Image("man sleep")
//                        }
//
//
//
//                        Button(action: { tutorialCount = tutorialCount + 1
//
//                            if (tutorialCount == 3){
//                                data_Test.tutorialOff()
//                            }
//
//                        }, label: { Text(tutorialCount == 2 ? "Explore" : "Next").foregroundColor(.white)}).offset(x: proxy.size.width * 0.35, y: proxy.size.height * 0.43)
//
//                    }.ignoresSafeArea()
//                }
            
//                SpriteView(scene: Rain(), options: [.allowsTransparency])

            
            }.position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
            
            
        }
    }
        
    
    private func sleepExactTime() -> Bool {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd "
        
        var critTimeString = dateFormatter.string(from: Date())
        critTimeString.append(String.init(format: "%.0f:00", wakeupTime))
        let critTime = dateTimeFormatter.date(from: critTimeString) ?? Date()
        
        let currentTime = Date()
        
        return (critTime.addingTimeInterval(-3600) < currentTime) &&
            (currentTime < critTime.addingTimeInterval(3600))
    }
    
    private func wakeupExactTime() -> Bool {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd "
        
        var critTimeString = dateFormatter.string(from: Date())
        critTimeString.append(String.init(format: "%.0f:00", sleepTime))
        let critTime = dateTimeFormatter.date(from: critTimeString) ?? Date()
        
        let currentTime = Date()
        
        return (critTime.addingTimeInterval(-3600) < currentTime) &&
            (currentTime < critTime.addingTimeInterval(3600))
    }
    
}







struct MainIsland2_Previews: PreviewProvider {

    @EnvironmentObject var data_Test: Data_Test

    static var previews: some View {
        MainIsland2(x: .constant(CGFloat(2.00)), wakeupTime: .constant(CGFloat(5.00)), sleepTime: .constant(CGFloat(0.00))).environmentObject(Data_Test()).onAppear(perform:{
            playSound(day: true)
            playAmbience(source: "Ambience")
        })


    }
}


// Life Status gif 변경
// Mainisland2 man gif 변경
// -> resonable time 에 작동 안되는거 어카노 
