//
//  Data_Test.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/20.
//

import Foundation
import SwiftUI


import UIKit



public class Data_Test: ObservableObject {
    @Published public var day: Bool = UserDefaults.standard.value(forKey: "day") == nil ? true : UserDefaults.standard.bool(forKey: "day") // 낮밤 변화
        
    @Published public var bedtime: Bool = UserDefaults.standard.bool(forKey: "bedTime")
    
    @Published public var ambience = UserDefaults.standard.value(forKey: "ambience") ?? true
    @Published public var music = UserDefaults.standard.value(forKey: "music") ?? true

    @Published public var wakeTime: Float = UserDefaults.standard.value(forKey: "wakeTime") == nil ? 7.0 : UserDefaults.standard.float(forKey: "wakeTime")// 일어난 시간
    @Published public var goalTime: Float = UserDefaults.standard.value(forKey: "sleepTime") == nil ? 23.0 : UserDefaults.standard.float(forKey: "sleepTime")// 잠든 시긴
    
    
    @Published public var changewakeTime: Float = UserDefaults.standard.value(forKey: "wakeTime") == nil ? 7.0 : UserDefaults.standard.float(forKey: "wakeTime")// 일어난 시간
    @Published public var changegoalTime: Float = UserDefaults.standard.value(forKey: "sleepTime") == nil ? 23.0 : UserDefaults.standard.float(forKey: "sleepTime")// 잠든 시긴
    
    
    @Published public var wakeupAngleValue: CGFloat = UserDefaults.standard.value(forKey: "wakeTime") == nil ? CGFloat(7.0 * 15) : CGFloat(UserDefaults.standard.float(forKey: "wakeTime") * 15)
    @Published public var sleepAngleValue: CGFloat = UserDefaults.standard.value(forKey: "sleepTime") == nil ? CGFloat(23.0 * 15) : CGFloat(UserDefaults.standard.float(forKey: "sleepTime") * 15)// 잠든 시긴
    
    @Published public var startTime  = UserDefaults.standard.array(forKey: "startTime") ?? [0, 0, 0, 0, 0, 0] // 실제 기록 잠든 시각
    @Published public var sleepFor = UserDefaults.standard.array(forKey: "sleepFor") ?? [0, 0, 0, 0, 0, 0] // 실제 기록 잠든 시간 량
    
//    @Published public var startTime: [Double]
//    @Published public var sleepFor: [Double]
    
    @Published public var makeUp: Int = UserDefaults.standard.integer(forKey: "makeUp")

    
    @Published var bleManager: BLEManager
    
    public var first: Bool = UserDefaults.standard.value(forKey: "first") == nil ? true :  UserDefaults.standard.bool(forKey: "first") // 낮밤 변화
    public var tutorial: Bool = UserDefaults.standard.bool(forKey: "tutorial") // default is false
    


    public var consistency = UserDefaults.standard.integer(forKey: "consistency")
    
    @Published var stack = UserDefaults.standard.array(forKey: "stack") ?? [0,0,0,0,0,0,0]
    

    
    init(){
        
        consistency = 6
//
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
//

                
        bleManager = BLEManager()
        
    }
    
    public func tutorialOff(){
        tutorial = true 
        UserDefaults.standard.set(true, forKey:"tutorial")
    }
    
    
    public func convertPoint(time: Double) -> CGFloat{
        return CGFloat(Double(time) + Double(time - Double(Int(time))) * 100 / 60)
    }
    
    
    
    public func startadd(time: Date){
        
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let starthour = components.hour!
        let startminute = components.minute!
        
        let save = Double(starthour) + Double(startminute)/100.0
////
        if first {
            startTime = [save, save, save, save, save]
            UserDefaults.standard.set(false, forKey: "first")
            first = false
        }
        else {
        startTime.remove(at: 0)
        startTime.append(save)
        UserDefaults.standard.set(startTime, forKey: "startTime")
        }
        
        makeUp = 0
        
        if bedtime {
            if consistency < 6{
                consistency += 1
                makeUp = -1
            }
        }
        else {
            if consistency > 0{
                consistency -= 1
                makeUp = 1
            }
        }
        for value in 0...6 {
            if(value < consistency){
                stack[value] = stack[value] as! Int + 1
            }else{
                break;
            }
            
        }
        
        UserDefaults.standard.set(makeUp, forKey: "makeUp")
        consistency = consistency + makeUp // 다시 빼줌
        UserDefaults.standard.set(stack, forKey: "stack")
        
    }
    
    func dateToStringChatTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: time)
        
    }

    
    public func foradd(time: Double){
        sleepFor.remove(at: 0)
        sleepFor.append(time)
        
        
        consistency = consistency - makeUp // 다시 더해줌 !
        UserDefaults.standard.set(consistency, forKey: "consistency")
        UserDefaults.standard.set(sleepFor, forKey: "sleepFor")
        
    }
    
    public func saveButton(){
            // 저장 버튼 누르면 값 전달
        
            wakeTime = floor(changewakeTime)
            goalTime = floor(changegoalTime)
        
            UserDefaults.standard.set(floor(changegoalTime), forKey: "sleepTime")
            UserDefaults.standard.set(floor(changewakeTime), forKey: "wakeTime")
            
    }
    
    public func loadTime(){
        changewakeTime = wakeTime
        changegoalTime = goalTime
        
        wakeupAngleValue = CGFloat(wakeTime * 15)
        sleepAngleValue = CGFloat(goalTime * 15)
        
        
    }
    
    public func reset(){
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
        // if default is false or 0 ? ex) bedtime, tutorial, consistency, no reset and just save
        
        UserDefaults.standard.set(true, forKey: "day")
        UserDefaults.standard.set(true, forKey: "ambience")
        UserDefaults.standard.set(true, forKey: "music")
        
        UserDefaults.standard.set(7.0, forKey: "wakeTime")
        UserDefaults.standard.set(23.0, forKey: "sleepTime")
        
        UserDefaults.standard.set(7.0, forKey: "changewakeTime")
        UserDefaults.standard.set(23.0, forKey: "changesleepTime")
        
        UserDefaults.standard.set([0, 0, 0, 0, 0, 0], forKey: "stack")
        
        
        wakeupAngleValue = 105.0
        sleepAngleValue = 345.0
        
        startTime = [0, 0, 0, 0, 0, 0]
        sleepFor = [0, 0, 0, 0, 0, 0]
        first = true
        
        

        
        
    }

    

    
    
}
