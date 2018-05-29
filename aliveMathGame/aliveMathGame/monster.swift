//
//  monster.swift
//  aliveMathGame
//
//  Created by Misha on 5/6/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import Foundation
import SpriteKit

class monster: SKNode {
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Monster   : UInt32 = 0b10      // 1
        static let fire: UInt32 = 0b1  // 2
        static let fires: UInt32 = 0b100 // 3
        static let player : UInt32 = 0b1000  // 4
    }
    
    
    var monsterObject = SKSpriteNode()
    let score = lifeScore(imageNamed: "monster")
    var gameover = false
    
    let monsterHitCategory = 2;
    override init(){
        super.init()
        monsterObject = SKSpriteNode(imageNamed: "spacestation.png")
        monsterObject.size = CGSize(width: 110.0, height: 100.0)
        monsterObject.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi/2), duration: 5)))
        monsterObject.physicsBody = SKPhysicsBody(circleOfRadius: monsterObject.size.width + 10)
        monsterObject.physicsBody?.isDynamic = true
        monsterObject.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monsterObject.physicsBody?.contactTestBitMask = PhysicsCategory.fire
        monsterObject.physicsBody?.collisionBitMask =  PhysicsCategory.None

        self.addChild(monsterObject)
        createMonsterLifeScore()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    func createMonsterLifeScore(){
        
         score.position = CGPoint(x: -290, y: 150)
        self.addChild(score)
    }
    
    func populateGuns() -> [SKSpriteNode]{
        var guns = [SKSpriteNode]()
        var i = 0
        while i < 6 {
         let emitterNode = SKSpriteNode(imageNamed: "fire")
            emitterNode.size = CGSize(width: 30.0, height: 30.0)
            emitterNode.position = CGPoint(x: 0.0, y: 0.0)
            
            let fireSound = SKAction.playSoundFileNamed("torpedo", waitForCompletion: true)
            emitterNode.run(fireSound)
            emitterNode.physicsBody = SKPhysicsBody(circleOfRadius: emitterNode.size.width)
            emitterNode.physicsBody?.isDynamic = true
            
            emitterNode.physicsBody?.categoryBitMask = PhysicsCategory.fires
            emitterNode.physicsBody?.contactTestBitMask = PhysicsCategory.player
            emitterNode.physicsBody?.collisionBitMask =  PhysicsCategory.None
            
            guns.append(emitterNode)
            i += 1
        }
        return guns
    }
    
    
    func generateDirections () -> [CGPoint]{
        var directions = [CGPoint]()
        var i = 0
        var angle = 0.0
        while i < 6 {
            let direction = CGPoint(x: cos(angle) * 200, y: sin(angle) * 200)
            directions.append(direction)
            i += 1
            angle += Double.pi / 3
        }
        return directions
    }
    
    func update()
    {
        _ = Timer.scheduledTimer(timeInterval: 5 , target: self, selector: #selector(self.gunShoot), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(self.wining), userInfo: nil, repeats: true)

    }
    func explosion(pos: CGPoint) {
        let emitterNode = SKEmitterNode(fileNamed: "ExplosionParticle.sks")
        emitterNode?.particlePosition = pos
        self.addChild(emitterNode!)
        //self.run(SKAction.wait(forDuration: 2), completion: { emitterNode?.removeFromParent() })
        
    }
    
    
    
    
    func wining() {
        if(gameover == false){
        if(self.score.score <= 0)
        {
            explosion(pos: self.monsterObject.position)
            self.monsterObject.removeFromParent()
            gameOver()
        }
        }
    }
    
    func gameOver(){
        gameover = true
        let label = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        label.fontSize = 32
        label.fontColor = UIColor.white
        label.text = "Yay! You did it !!"
        self.addChild(label)
        
        label.alpha = 0
        label.xScale = 0.2
        label.yScale = 0.2
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let scaleIn = SKAction.scale(to: 1, duration: 2)
        let fadeScale = SKAction.group([fadeIn, scaleIn])
        label.run(fadeScale)
        
    }
    
    
    func gunShoot() {
        
        let emitters = populateGuns()
        let directions = generateDirections()
        var i = 0
        while i < emitters.count {
        let shooting = SKAction.move(to: directions[i], duration: 1)
        let shootingDone = SKAction.removeFromParent()
        emitters[i].run(SKAction.sequence([shooting, shootingDone]))
        monsterObject.addChild(emitters[i])
            i += 1
        }
        
    }
}
