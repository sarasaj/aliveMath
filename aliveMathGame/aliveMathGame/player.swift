//
//  player.swift
//  aliveMathGame
//
//  Created by Misha on 5/1/17.
//  Copyright © 2017 SMORE. All rights reserved.
//

import Foundation
import SpriteKit

class player: SKNode {
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Monster   : UInt32 = 0b10      // 1
        static let fire: UInt32 = 0b1  // 2
        static let fires: UInt32 = 0b100 // 3
        static let player : UInt32 = 0b1000  // 4
    }
    
    var playerObject = SKSpriteNode()
    var angle = CGFloat()
    var orbitingXLabel = SKLabelNode() , orbitingYLabel = SKLabelNode()  , Label1 = SKLabelNode() , Label2 = SKLabelNode() , Label3 = SKLabelNode()
    var vectorsLabel = SKNode()
     var bubble = SKSpriteNode() , playerFire = SKSpriteNode()
    var gameover = false
    var protected = false
    let score = lifeScore(imageNamed: "nerdStudent")

    override init(){
        super.init()
        playerObject = SKSpriteNode(imageNamed: "spaceShip.png")
        playerObject.size = CGSize(width: 70.0, height: 70.0)
        playerObject.position = CGPoint(x: 0.0, y: 0.0)
        playerObject.name = "player"
        playerObject.isUserInteractionEnabled = false
        playerObject.physicsBody = SKPhysicsBody(circleOfRadius: playerObject.size.width - 40)
        playerObject.physicsBody?.isDynamic = true
        
        playerObject.physicsBody?.categoryBitMask = PhysicsCategory.player
        playerObject.physicsBody?.contactTestBitMask = PhysicsCategory.fires
        playerObject.physicsBody?.collisionBitMask =  PhysicsCategory.None
        

        
        createPlayerLifeScore()
        createBubble()
        vectorsEquation()
        self.addChild(playerObject)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func explosion(pos: CGPoint) {
        let emitterNode = SKEmitterNode(fileNamed: "ExplosionParticle.sks")
        emitterNode?.particlePosition = pos
       // let explosionSound = SKAction.playSoundFileNamed("explosion", waitForCompletion: true)
        //emitterNode?.run(explosionSound)
        self.addChild(emitterNode!)
        // Don't forget to remove the emitter node after the explosion
        
        
        //self.run(SKAction.wait(forDuration: 2), completion: { emitterNode?.removeFromParent() })
        
    }
    
    func lifeLost() {
        if(gameover == false){
        if(self.score.score <= 0)
        {
            explosion(pos: self.playerObject.position)
            self.playerObject.removeFromParent()
            gameOver()
        }
        }
    }
    
    func gameOver(){
        gameover = true
        let label = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        label.fontSize = 32
        label.fontColor = UIColor.red
        label.text = "Game Over !!"
        self.addChild(label)
        
        label.alpha = 0
        label.xScale = 0.2
        label.yScale = 0.2
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let scaleIn = SKAction.scale(to: 1, duration: 2)
        let fadeScale = SKAction.group([fadeIn, scaleIn])
        label.run(fadeScale)
        
    }

    
    
    func createBubble()
    {
        bubble = SKSpriteNode(imageNamed: "bubble2")
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.size.width)
        bubble.physicsBody?.isDynamic = false
        bubble.size = playerObject.size
    }
    
    
    func orbitRotation(monsterPosition: CGFloat , playerPosition: CGFloat){
        let radius = monsterPosition - playerPosition
        
        
        orbitEquation()
        
        var i = 0
        var labelChanging = SKAction()
        var angles = [CGFloat]()
        var move = SKAction()
        var actions = [SKAction]()
        while(angle <= (2 * CGFloat.pi)){
          
           angle += (CGFloat.pi/16)
           angles.append(angle)
           
           labelChanging  = SKAction.run {
                self.updateOrbitingLabel(angle: angles[i % angles.count])
                i += 1
            }
            
           move = SKAction.move(to: CGPoint(x: cos(angle) * radius, y: sin(angle) * radius),duration: 0.5)
           actions.append(SKAction.group([labelChanging , move]))
        }
        
        
        playerObject.run(SKAction.repeatForever(SKAction.sequence(actions)))
    }
    
    
    func updateOrbitingLabel(angle: CGFloat){
        self.orbitingXLabel.text = NSString(format: "x = cos (%f)", angle ) as String
        
        self.orbitingYLabel.text = NSString(format: "y = sin(%f)", angle ) as String
    }
    
    func updateVectorsLabel(mPosition: CGPoint , hPosition: CGPoint , gunVector : CGPoint)
    {
    self.Label1.text = NSString(format: "Monster position = (x = %f , y = %f)", mPosition.x , mPosition.y ) as String
    self.Label2.text = NSString(format: "Hero position = (x = %f , y = %f) ",hPosition.x,hPosition.y ) as String
    self.Label3.text = NSString(format: "Gun vector = (x = %f , y = %f)",gunVector.x,gunVector.y) as String
    
    }
   
    
    func sub(mPoint: CGPoint , pPoint : CGPoint) -> CGPoint {
      let dx = mPoint.x - pPoint.x
      let dy = mPoint.y - pPoint.y
        return CGPoint(x: dx , y: dy)
        
    }
    
    func orbitEquation(){
        
        
        let orbitingLabel =  SKNode()
        orbitingLabel.position =  CGPoint(x: 50, y: -50)
        
        self.orbitingXLabel = SKLabelNode(fontNamed: "AvenirNext-Medium")
        orbitingXLabel.fontSize = 11
        orbitingXLabel.fontColor = UIColor.white
        orbitingXLabel.text = " "
        orbitingLabel.addChild(self.orbitingXLabel)
        
        self.orbitingYLabel = SKLabelNode(fontNamed: "AvenirNext-Medium")
        orbitingYLabel.fontSize = 11
        orbitingYLabel.fontColor = UIColor.white
        orbitingYLabel.text = " "
        orbitingYLabel.position = CGPoint(x:0.0, y:-10.0)
        orbitingLabel.addChild(self.orbitingYLabel)
        
        self.playerObject.addChild(orbitingLabel)
        
        
    }
    
    func createPlayerLifeScore(){
        score.position = CGPoint(x: 220, y: 150)
        self.addChild(score)
    }
   
    
    func removeProtection()
    {
        protected = false
        bubble.removeFromParent()
    }
    func protection()
    {
        protected = true
        bubble.size = playerObject.size
        playerObject.addChild(bubble)
    }
    
    func vectorsEquation(){
        Label1 = SKLabelNode(fontNamed: "AvenirNext-Medium")
        Label1.fontSize = 11
        Label1.fontColor = UIColor.white
        Label1.text = " "
        Label1.position =  CGPoint(x: -10.0, y: 0.0)
        Label1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        vectorsLabel.addChild(Label1)
        
        Label2 = SKLabelNode(fontNamed: "AvenirNext-Medium")
        Label2.fontSize = 11
        Label2.fontColor = UIColor.white
        Label2.text = " "
        Label2.position =  CGPoint(x: -10.0, y: -10)
        Label2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        vectorsLabel.addChild(Label2)
        
        Label3 = SKLabelNode(fontNamed: "AvenirNext-Medium")
        Label3.fontSize = 11
        Label3.fontColor = UIColor.white
        Label3.text = " "
        Label3.position =  CGPoint(x: -10.0, y: -20)
        Label3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        vectorsLabel.addChild(Label3)
        self.vectorsLabel.position = CGPoint(x: -290.0, y: 110)
        self.addChild(vectorsLabel)
        
        
    }
    
    
    
  
    func update()
    {
        
        _ = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(self.lifeLost), userInfo: nil, repeats: true)
        
    }
    
    func gunShoot(monsterPosition: CGPoint , playerPosition : CGPoint) {
        
        playerFire = SKSpriteNode(imageNamed: "fire")
        playerFire.size = CGSize(width: 30.0, height: 30.0)
        playerFire.position = CGPoint(x: 0.0, y: 0.0)
        playerFire.physicsBody = SKPhysicsBody(circleOfRadius: playerFire.size.width)
        playerFire.physicsBody?.isDynamic = true
        
        playerFire.physicsBody?.categoryBitMask = PhysicsCategory.fire
        playerFire.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        playerFire.physicsBody?.collisionBitMask =  PhysicsCategory.None
        
        
        let subPoint = sub(mPoint:monsterPosition, pPoint:playerPosition)
        let shooting = SKAction.move(to: subPoint, duration: 1)
        let shootingDone = SKAction.removeFromParent()

        updateVectorsLabel(mPosition: monsterPosition, hPosition: playerPosition, gunVector: subPoint)
        
        playerFire.run(SKAction.sequence([shooting, shootingDone]))
        playerObject.addChild(playerFire)

       
        // Don't forget to remove the emitter node after the explosion
//        self.run(SKAction.wait(forDuration: 2), completion: { emitterNode?.removeFromParent() })
        
    }
    
}
