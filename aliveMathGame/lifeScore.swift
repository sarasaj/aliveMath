//
//  lifeScore.swift
//  aliveMathGame
//
//  Created by Misha on 5/8/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import Foundation
import SpriteKit

class lifeScore:SKNode{
    
    var owner = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var score = Int()
    
    init(imageNamed: String){
        super.init()
        owner = SKSpriteNode(imageNamed: imageNamed)
        owner.size = CGSize(width: 30.0, height: 30.0)
        self.addChild(owner)
        
        score = 100
        scoreLabel.text = String(score)
        scoreLabel.position = CGPoint(x: 50, y: 0.0)
        self.addChild(scoreLabel)
    }
    
    func hurt(){
        self.score -= 10
        updateLabel(score: self.score)
    }
    
    func updateLabel(score: Int)
    {
        self.scoreLabel.text = NSString(format: " %i", score ) as String
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
