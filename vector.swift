//
//  vector.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 5/1/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation


import Foundation

class Vector:SCNNode{
    
    
    let startpoint = SCNVector3(0,0,0)
    
    var vector1 = drawline()
    var vector2 = drawline()
    var vector3 = drawline()
    
    
    var x1 = 1.0
    var y1 = 1.5
    var z1 = 3.0
    
    var x2 = 3.0
    var y2 = 3.0
    var z2 = 3.0
    
    
    var radius: CGFloat
    var color: UIColor
    
    
    override init()
    {
        
        self.radius = 0.1
        self.color = .black
        
        super.init()
        
        self.x1 = Double(x1)
        self.y1 = Double(y1)
        self.z1 = Double(z1)
        
        
        
        self.x2 = Double(x2)
        self.y2 = Double(y2)
        self.z2 = Double(z2)
        
        self.addChildNode(vector1)
        self.addChildNode(vector2)
        //self.addChildNode(vector3)
        
        self.VectorsAddition()
        
    }
    
    
    func alterVectors(vector1: SCNVector3 , vector2: SCNVector3){
        
        self.x1 = Double(vector1.x)
        self.y1 = Double(vector1.y)
        self.z1 = Double(vector1.z)
        
        
        
        self.x2 = Double(vector2.x)
        self.y2 = Double(vector2.y)
        self.z2 = Double(vector2.z)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func VectorsAddition (){
        
        vector1 = vector1.DrawLine(from: startpoint, to: SCNVector3(self.x1,self.y1,self.z1), radius: radius, color: vector1.setColor(color: .blue)) as! drawline
        
        vector2 = vector2.DrawLine(from: startpoint, to: SCNVector3(self.x2,self.y2,self.z2), radius: radius, color: vector2.setColor(color: .green)) as! drawline
        
        vector3 = vector3.DrawLine(from: startpoint, to: SCNVector3((self.x1+self.x2),(self.y1+self.y2),(self.z1+self.z2)), radius: radius, color: vector3.setColor(color: .red)) as! drawline
        
        self.addChildNode(vector3)
        
    }
    
    func setendPoints(a:Double,b:Double,c:Double,d:Double,e:Double,f:Double)
    {
        self.x1=a
        self.y1=b
        self.z1=c
        
        self.x2=d
        self.y2=e
        self.z2=f
        
    }
    
    func update()
    {
        VectorsAddition()
        
    }
    
    
    
    
}
