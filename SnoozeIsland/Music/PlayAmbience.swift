//
//  PlayMusicNight.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/21.
//


import SwiftUI
import AVFoundation

var playerA:AVAudioPlayer!

func playAmbience(source: String){

    let url = Bundle.main.url(forResource: source, withExtension: "wav")

    //Do nothing if url is empty
    guard url != nil else{
       return
    }
    
    do{
        playerA = try AVAudioPlayer(contentsOf: url!)
        playerA.volume = 2.0
        playerA.numberOfLoops = -1
        playerA?.play()
    } catch{
        print("error")
    }
}


