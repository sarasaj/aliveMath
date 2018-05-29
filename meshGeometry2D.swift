//
//  meshGeometry2D.swift
//  VuforiaSampleSwift
//
//  Created by Rawan Abdullah on 5/9/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SpriteKit

class meshGeometry2D : SKNode{
    
    var positions = [CGPoint]()
    
    override init(){
        super.init()
        
        var i = 0
        drawPath()
        print(positions)
        while i < positions.count-2 {
            let j = i + 1
            
            let line_path = CGMutablePath()
            
            drawLine(path: line_path ,num1: positions[i], num2: positions[j])
            
            let lineShape = SKShapeNode()
            lineShape.path = line_path
            lineShape.strokeColor = UIColor.white
            lineShape.lineWidth = 3
            self.addChild(lineShape)
            i += 1
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func drawPath(){
        var i = -400.7
        while i <= 500.0 {
            positions.append(CGPoint(x: Double(i), y: 0.0))
            i += 15.7
            
        }
    }
    
    func drawLine(path: CGMutablePath, num1: CGPoint, num2: CGPoint ){
        let startingPoint = num1
        let controlPoint1 = CGPoint(x: (num1.x + num2.x)/2 , y:sin( ((num1.x + num2.x)/2)) * 100 )
        let endingPoint = num2
        path.move(to: startingPoint)
        path.addQuadCurve(to: endingPoint, control: controlPoint1)
    }
    
}
