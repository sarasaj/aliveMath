//
//  vectors2d.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 5/9/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SpriteKit

class vectors2d : SKNode{
    
    var vector1 = CGPoint() , vector2 = CGPoint()
    
    var positions = [CGPoint]()
    
    override init(){
        super.init()
        
    }
    
    func draw(){
        var i = 0
        
        positions.append(vector1)
        positions.append(vector2)
        positions.append(sum(vector1: vector1, vector2: vector2))
        
        while i < positions.count {
            
            let line_path = CGMutablePath()
            
            drawLine(path: line_path ,num1: positions[i])
            
            let lineShape = SKShapeNode()
            lineShape.path = line_path
            lineShape.strokeColor = UIColor.white
            lineShape.lineWidth = 3
            self.addChild(lineShape)
            i += 1
        }
        
        
    }
    
    func setVectors(vector1: CGPoint , vector2: CGPoint){
        self.vector1 = vector1
        self.vector2 = vector2
    }
    
    func sum(vector1: CGPoint, vector2: CGPoint)-> CGPoint{
        return CGPoint(x: vector1.x + vector2.x, y: vector1.y + vector2.y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func drawLine(path: CGMutablePath, num1: CGPoint){
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endingPoint = num1
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
    }
    
}
