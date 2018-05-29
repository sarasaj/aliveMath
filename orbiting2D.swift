//
//  spriteNode.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 4/20/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SpriteKit

class orbiting2D : SKNode{
    
    var moon = SKShapeNode()
    var earth = SKShapeNode()
    
    override init(){
        super.init()
        
        moon = SKShapeNode(circleOfRadius: 25)
        moon.strokeColor = UIColor.black
        self.addChild(moon)
        
        
        earth = SKShapeNode(circleOfRadius: 60)
        earth.strokeColor = UIColor.black
        self.addChild(earth)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func orbitRotation(position: Double){
        var angle = 0.0
        var actions = [SKAction]()
        while(angle <= (2 * Double.pi)){
            angle += (Double.pi/16)
            actions.append(SKAction.move(to: CGPoint(x: cos(angle) * 90 + position/2, y: sin(angle) * 90 + position/2 ),duration: 1))
        }
        moon.run(SKAction.repeatForever(SKAction.sequence(actions)))
        
    }
    
}
