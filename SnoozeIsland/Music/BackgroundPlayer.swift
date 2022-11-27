//
//  BackgroundPlayer.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/28.
//

import SwiftUI

struct BackgroundPlayer: View {
    @EnvironmentObject var data_Test : Data_Test

        var body: some View {
//
            VStack{
                Button(action: {
                    playSound(day: data_Test.day)
//                    playSound(day: true)

                }){
                    Text("Play Sound")
                }
//
                Button(action: {
                    player.setVolume(0, fadeDuration : 1.5)}){
                    Text("Stop")
                }
            }
        }
    }


struct BackgroundPlayer_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundPlayer()
    }
}
