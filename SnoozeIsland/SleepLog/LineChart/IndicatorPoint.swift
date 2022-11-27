//
//  IndicatorPoint.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/01/01.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Colors.GradientPurple)
            Circle()
                .stroke(Color.white, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14)
        .shadow(color: Colors.LegendColor, radius: 6, x: 0, y: 6)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}

