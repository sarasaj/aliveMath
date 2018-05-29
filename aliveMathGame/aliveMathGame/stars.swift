//
//  stars.swift
//  aliveMathGame
//
//  Created by Misha on 5/1/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import Foundation
import SpriteKit

class stars : SKNode {
    
    
    override init() {
        super.init()
        let weakSelf = self
        let update = SKAction.run {
            if(arc4random_uniform(20) > 3){
                weakSelf.createStars()
            }
        }
        
        let delay = SKAction.wait(forDuration: 0.1)
        let updateLoop = SKAction.sequence([delay , update])
        self.run(SKAction.repeatForever(updateLoop))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createStars(){
        let randomeX = arc4random_uniform(UInt32((self.scene?.size.width)!))
        let maxY = self.scene?.size.height
        
        let randomeStar = CGPoint(x: CGFloat(randomeX), y: maxY!)
        let star = SKSpriteNode(imageNamed: "spark")
        star.position = randomeStar
        star.size = CGSize(width: 2.0, height: 10.0)
        star.alpha = CGFloat(0.1 + (Double(arc4random_uniform(10)) / 10.0))
        self.addChild(star)
        
        let destinationY = 0 - (self.scene?.size.height)! - star.size.height
        let duration = 0.1 + ( Double(arc4random_uniform(10))/10.0)
        let move = SKAction.moveBy(x: 0, y: destinationY, duration: duration)
        let remove = SKAction.removeFromParent()
        star.run(SKAction.sequence([move , remove]))
        
        
    }
}
