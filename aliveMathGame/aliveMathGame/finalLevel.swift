//
//  finalLevel.swift
//  aliveMathGame
//
//  Created by Misha on 5/5/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import Foundation
import SpriteKit

class finalLevel : SKScene, SKPhysicsContactDelegate {
   
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Monster   : UInt32 = 0b10      // 1
        static let fire: UInt32 = 0b1  // 2
        static let fires: UInt32 = 0b100 // 3
         static let player : UInt32 = 0b1000  // 4
    }
    
    private var monsterSpace = monster()
    private var playerObj = player()
    private let starsFeild = stars()
    private let stonesFeild = stones()
    
    
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.black
        self.name = "scene"
        self.addChild(starsFeild)
        self.addChild(stonesFeild)
        monsterSpace.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.addChild(monsterSpace)
        
        playerObj.position = CGPoint(x: self.frame.size.width/2 , y: self.frame.size.height/2)
        playerObj.orbitRotation(monsterPosition: monsterSpace.monsterObject.size.width/2 , playerPosition: playerObj.position.y)
        self.addChild(playerObj)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        monsterSpace.update()
        playerObj.update()
    }
    

    
    func fireCollideWithMonster() {
        if(monsterSpace.score.score > 0) {
        monsterSpace.score.hurt()
        }
    }
    
    func fireCollideWithPlayer() {
        if(playerObj.protected == false){
       
            if(monsterSpace.score.score > 0){
            playerObj.score.hurt()
            }
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.categoryBitMask == PhysicsCategory.fire &&  secondBody.categoryBitMask == PhysicsCategory.Monster ){
       
                fireCollideWithMonster()
            
            
        } else if(firstBody.categoryBitMask == PhysicsCategory.fires &&  secondBody.categoryBitMask == PhysicsCategory.player ){
            
                fireCollideWithPlayer()
            
        }
        
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
 
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
   
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            
           self.touchDown(atPoint: t.location(in: self))
        }
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if(touch.tapCount == 2)
        {
            playerObj.removeProtection()
        }
        
        if let name = touchedNode.name
        {
            if name == "player"
            {
                if(playerObj.protected == false){
                 playerObj.protection()
                }
                
            } else if name == "scene" {
                let positionInScene = self.convert(self.playerObj.playerObject.position, from: self.playerObj)
                playerObj.gunShoot(monsterPosition:self.monsterSpace.position , playerPosition: positionInScene)
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
           
        }
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
 
    
    //explosion particle when the space explodes
   
}
