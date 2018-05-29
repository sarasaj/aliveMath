//
//  stones.swift
//  aliveMathGame
//
//  Created by Misha on 5/6/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import Foundation
import SpriteKit

class stones : SKNode {
    
    var sineLabel = SKLabelNode()
    override init() {
        super.init()
        let weakSelf = self
        let update = SKAction.run {
            
                weakSelf.createStones()
            
        }
        
        let delay = SKAction.wait(forDuration: 5)
        let updateLoop = SKAction.sequence([delay , update])
        self.run(SKAction.repeatForever(updateLoop))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sineEquation() -> SKLabelNode{
        sineLabel = SKLabelNode(fontNamed: "AvenirNext-Medium")
        sineLabel.fontSize = 11
        sineLabel.fontColor = UIColor.white
        sineLabel.text = "x = sin(y)"
        sineLabel.position =  self.position
        return sineLabel
        
        
    }
    
    func createStones(){
        let randomeX = arc4random_uniform(UInt32((self.scene?.size.width)!))
        let maxY = self.scene?.size.height
        
        let randomeStone = CGPoint(x: CGFloat(randomeX), y: maxY!)
        let stone = SKSpriteNode(imageNamed: "spacestone2")
        stone.name = "stone"
        stone.isUserInteractionEnabled = false
        stone.position = randomeStone
        stone.size = CGSize(width: 50.0, height: 50.0)
        stone.alpha = CGFloat(0.1 + (Double(arc4random_uniform(10)) / 10.0))
        stone.addChild(sineEquation())
        self.addChild(stone)
        
        let destinationY = 0 - (self.scene?.size.height)! - stone.size.height
        let duration = 5.0
        
        let moveRight = SKAction.moveBy(x: sin(destinationY / 6) * 50, y: destinationY / 6, duration: duration)
        let moveLeft = SKAction.moveBy(x: sin((destinationY / 6) * -1) * 50, y: destinationY / 6, duration: duration)
        
        let remove = SKAction.removeFromParent()
        
        stone.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))
        
        if(stone.position.y < destinationY)
        {
            stone.run(remove)
        }
        
    }
    
    
}
