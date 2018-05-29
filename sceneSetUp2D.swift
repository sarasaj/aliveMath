//
//  scenesetUp2D.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 4/30/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit

class sceneSetUp2d : SCNNode {
    var spriteSceneNode = SCNNode()
    let sprite = SKScene(size: CGSize(width: 300 , height: 300))
    let spriteNode2D = orbiting2D()
    let mesh2D = meshGeometry2D()
    let vectors = vectors2d()
    var positions = [CGPoint]()
    
    
    init (sceneName: String) {
        super.init()
        let spriteNode = SCNPlane(width: 5, height: 5.5)
        
        sprite.backgroundColor = UIColor.clear
        
        let cubeMaterial = SCNMaterial()
        cubeMaterial.diffuse.contents = sprite
        spriteNode.materials = [cubeMaterial]
        spriteSceneNode = SCNNode(geometry: spriteNode)
        
       // drawAxis()
        sceneSwitcher(sceneName: sceneName)
        //spriteSceneNode.runAction(SCNAction.rotateBy(x: 90, y: 0, z: 0, duration: 1))
        self.addChildNode(spriteSceneNode)
        
    }
    func fillPositions(){
        let xAxisSt = CGPoint(x: -300, y: 0.0)
        let xAxisEd = CGPoint(x: 300, y: 0.0)
        let yAxisSt = CGPoint(x: 0.0, y: -300.0)
        let yAxisEd = CGPoint(x: 0.0, y: 300.0)
        positions.append(xAxisSt)
        positions.append(xAxisEd)
        positions.append(yAxisSt)
        positions.append(yAxisEd)
    }
    func drawAxis() {
        
        fillPositions()
        var i = 0
        
        while i < positions.count - 1 {
            let j = i + 1
            let line_path = CGMutablePath()
            
            drawLine(path: line_path ,num1: positions[i] , num2:positions[j])
            
            let lineShape = SKShapeNode()
            lineShape.path = line_path
            lineShape.strokeColor = UIColor.black
            lineShape.lineWidth = 3
            lineShape.position =  CGPoint(x: sprite.size.width/2, y: sprite.size.height/2.0)
            sprite.addChild(lineShape)
            i += 2
        }
        
    }
    
    
    func drawLine(path: CGMutablePath, num1: CGPoint, num2: CGPoint){
        let startingPoint = num1
        let endingPoint = num2
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sceneSwitcher(sceneName:String){
        switch(sceneName){
        case "image1": create2DSpace()
            break
        case "sin": creat2DMesh()
            break
        case "vectors": create2Dvectors()
            break
        default: break
        }
    }
    func create2DSpace(){
        
        spriteNode2D.moon.position = CGPoint(x: sprite.size.width/2.0 + 20 , y: sprite.size.height/2.0)
        spriteNode2D.earth.position = CGPoint(x: sprite.size.width/2, y: sprite.size.height/2.0)
        spriteNode2D.orbitRotation(position: Double(sprite.size.width))
        sprite.addChild(spriteNode2D)
    }
    
    func creat2DMesh(){
        mesh2D.position = CGPoint(x: sprite.size.width/2.0, y: sprite.size.height/2.0)
        sprite.addChild(mesh2D)
    }
    
    func create2Dvectors(){
        vectors.setVectors(vector1: CGPoint(x: 30.0, y: 20) , vector2: CGPoint(x: -60.0, y:70.0))
        vectors.draw()
        vectors.position = CGPoint(x: sprite.size.width/2.0, y: sprite.size.height/2.0)
        sprite.addChild(vectors)
    }
}
