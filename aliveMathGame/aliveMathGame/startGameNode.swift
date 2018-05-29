//
//  startGameNode.swift
//  aliveMathGame
//
//  Created by Misha on 5/5/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import Foundation
import SpriteKit


class startGameNode : SKNode {
    override init() {
        
        super.init()
      let label = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        label.fontSize = 32
        label.fontColor = UIColor.white
        label.text = " Math is FUN!!"
        self.addChild(label)
        
        label.alpha = 0
        label.xScale = 0.2
        label.yScale = 0.2
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let scaleIn = SKAction.scale(to: 1, duration: 2)
        let fadeScale = SKAction.group([fadeIn, scaleIn])
        label.run(fadeScale)
        
        let instructions = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        instructions.fontSize = 14
        instructions.fontColor = UIColor.white
        instructions.text = "Tap to start the GAME!!"
        instructions.position = CGPoint(x:0.0 , y: -45.0)
        self.addChild(instructions)
        
        instructions.alpha = 0
        let wait = SKAction.wait(forDuration: 4)
        let appear = SKAction.fadeAlpha(to: 1, duration: 0.2)
        let popUp = SKAction.scale(to: 1.1 , duration: 0.1)
        let dropDown = SKAction.scale(to: 1, duration: 0.1)
        let pausAppear = SKAction.group([wait, appear,popUp, dropDown])
        let repeatActions = SKAction.repeatForever(pausAppear)
        instructions.run(repeatActions)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
