//
//  CloudMove.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2022/07/06.
//

import SwiftUI

import SpriteKit



class CloudMove: SKScene{
    override func sceneDidLoad() {
        
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backgroundColor = .clear
        
        
        let node = SKEmitterNode(fileNamed: "MovingCloud")!
        addChild(node)

        
        
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particlePositionRange.dy = UIScreen.main.bounds.height

    }
}
