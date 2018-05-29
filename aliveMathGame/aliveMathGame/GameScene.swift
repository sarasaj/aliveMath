//
//  GameScene.swift
//  aliveMathGame
//
//  Created by Misha on 4/26/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    
    private let starsFeild = stars()
    override func didMove(to view: SKView) {
         
        self.backgroundColor = UIColor.black
       
        self.addChild(starsFeild)
        let startNode = startGameNode()
        startNode.position = CGPoint(x: 355.5 , y: 150)
        self.addChild(startNode)
    
        let scoreFormatter = NumberFormatter()
        scoreFormatter.numberStyle = .decimal
        
        let scoreText =  String(format: "%@%x", " High Score ", 0.0)
        
        
        let instructions = SKLabelNode(fontNamed: "AvenirNext-Medium")
        instructions.fontSize = 16
        instructions.fontColor = UIColor.white
        instructions.text = scoreText
        instructions.position = CGPoint(x:355.5 , y: 70.0)
        self.addChild(instructions)
    
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
           }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        let final = finalLevel()
        final.size = self.frame.size
        let transaction = SKTransition()
        
        self.view?.presentScene(final, transition: transaction)
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
