//
//  spriteNode.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 4/22/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SpriteKit

class spriteNode : SKNode{
    
    
    var piCircle = SKNode()
    
    override init(){
        super.init()
        
        self.piCircle.name = "piCircle"
        self.piCircle = SKShapeNode(circleOfRadius: CGFloat(150) ) // Size of Circle
        piCircle.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(piCircle)
        
        let line_path:CGMutablePath = CGMutablePath()
        
        drawLine(path: line_path)
        let shape = SKShapeNode()
        shape.path = line_path
        shape.strokeColor = UIColor.white
        shape.lineWidth = 2
        shape.position = CGPoint(x:0.0,y:0.0)
        self.addChild(shape)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLine(path: CGMutablePath){
        print("pi magnitude \(Double.pi.magnitude)")
        path.move(to: CGPoint(x:-100, y: 0))
        path.addQuadCurve(to: CGPoint(x:100, y: 0), control: CGPoint(x:0, y: 2))
    }
    
}
