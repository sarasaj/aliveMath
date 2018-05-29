//
//  orbitingScene.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 3/25/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SceneKit
class space: SCNNode{
    
    
    let moon = SCNNode()
    let earth = SCNNode()
    var staticAngel = Double()
    var velocity = Double()
    var radius = Double()
    
    override init(){
        super.init()
        
        self.staticAngel = Double.pi/8
        self.velocity = 1
        self.radius = 1
        
        self.moon.name = "moon"
        self.moon.geometry = SCNSphere(radius: 0.1)
        self.moon.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"moonTexture.png")
        self.moon.position = SCNVector3(1,0.0,0.0)
        self.addChildNode(moon)
        
        
        
        self.earth.name = "earth"
        self.earth.geometry = SCNSphere(radius: 0.5)
        self.earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"earthTexture.jpg")
        self.earth.position = SCNVector3(0.0,0.0,0.0)
        self.earth.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0.0, y: 1.0, z: 0.0, duration: 1)))
        self.addChildNode(earth)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func orbitRotation(){
        
        var angle = 0.0
        var actions = [SCNAction]()
        while(angle <= (2 * Double.pi)){
            angle += self.staticAngel
            actions.append(SCNAction.move(to: SCNVector3((cos(angle) * self.radius), (sin(angle) * self.radius) ,0.0) ,duration: self.velocity))
        }
        
        
        self.moon.runAction(SCNAction.repeatForever(SCNAction.sequence(actions)))
    }
    
    func update(){
        orbitRotation()
    }
    
    func alterRadius(radius:Double)
    {
        self.radius += radius-1
    }
    
    func alterAngel(newAngel:Double)
    {
        self.staticAngel = newAngel
    }
    
    func alterVelocity(velocity: Double)
    {
        self.velocity = velocity
    }
}
