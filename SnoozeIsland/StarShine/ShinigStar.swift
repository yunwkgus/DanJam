//
//  ShinigStar.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/03/10.
//

import SwiftUI

import SpriteKit



class StarShine: SKScene{
    override func sceneDidLoad() {
        
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backgroundColor = .clear
        
        
        let node = SKEmitterNode(fileNamed: "StarShine")!
        addChild(node)
        
        
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particlePositionRange.dy = UIScreen.main.bounds.height
    }
}
