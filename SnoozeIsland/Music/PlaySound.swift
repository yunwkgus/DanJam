//
//  PlayMusic.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/28.
//

import SwiftUI
import AVFoundation

var player:AVAudioPlayer!

func playSound(day: Bool){

//    let url = Bundle.main.url(forResource: day ? "sleep daytime bpm90" : "sleep night bpm95", withExtension: "mp3")
//    let url = Bundle.main.url(forResource: day ? "sleep daytime bpm90" : "시라시파수면", withExtension: "mp3")
    let url = Bundle.main.url(forResource: day ? "sleep daytime bpm90" : "시라시파수면" , withExtension: "mp3")


    //Do nothing if url is empty
    guard url != nil else{
       return
    }
    
    do{
        player = try AVAudioPlayer(contentsOf: url!)
        player.numberOfLoops = -1
        player.setVolume(0, fadeDuration: 2)
        player.setVolume(1, fadeDuration: 2)
        player?.play()
    } catch{
        print("error")
    }
}


