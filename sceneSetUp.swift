//
//  sceneSetUp.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 3/25/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class sceneSetUp : SCNScene {
    
    var currentNode = SCNNode()
    var spriteSceneNode = SCNNode()
    var axisNode = SCNNode()
    var scene2D = false
    var currentSceneName = String()
    
    
    override init () {
        super.init()
        create3DScene()
        
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setCurrentNode(currentNode: SCNNode)
    {
        self.currentNode = currentNode
        self.rootNode.addChildNode(self.currentNode)
        
    }
    
    func create3DScene(){
        
        axisNode = createAxis()
        self.rootNode.addChildNode(axisNode)
        
        let lightNode = createLight(type:.omni , color:UIColor.white)
        lightNode.position = SCNVector3(x:0, y:0, z:10)
        self.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = createLight(type:.ambient , color:UIColor.lightGray)
        self.rootNode.addChildNode(ambientLightNode)
        
    }
    
    func clean3DScene(b: Bool){
        axisNode.isHidden = b
        self.currentNode.isHidden = b
        
    }
    
    func clean2DScene(b: Bool){
        spriteSceneNode.isHidden = b
    }
    
    func resetScene(id: Int , scene: String){
        self.currentSceneName = scene
        switch(id){
        case 1:
            clean2DScene(b: true)
            clean3DScene(b:false)
            break
        case 2:
            clean3DScene(b: true)
            if(!scene2D){
                create2DScene()
            } else {
                clean2DScene(b:false)
            }
            break
        default:
            break
        }
    }
    
    func create2DScene(){
        
        scene2D = true
        spriteSceneNode = sceneSetUp2d(sceneName: self.currentSceneName)
        self.rootNode.addChildNode(spriteSceneNode)
        
    }
    
    
    func getCurrentNode()->SCNNode{
        return self.currentNode
    }
    
    
    
    
    func createLight(type: SCNLight.LightType , color: UIColor) ->SCNNode
    {
        
        let LightNode = SCNNode()
        LightNode.light = SCNLight()
        LightNode.light?.type = type
        LightNode.light?.color = color
        return LightNode
        
    }
    
    
    func createAxis()->SCNNode {
        
        let axisNode = SCNNode()
        let xAxis = SCNNode()
        xAxis.geometry = SCNCylinder(radius: CGFloat(0.01) , height: CGFloat(10.0))
        xAxis.position = SCNVector3 (0.0, 0.0,0.0)
        xAxis.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(Double.pi / 2))
        xAxis.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        axisNode.addChildNode(xAxis)
        
        
        let yAxis = SCNNode()
        yAxis.geometry = SCNCylinder(radius: CGFloat(0.01) , height: CGFloat(10.0))
        yAxis.position = SCNVector3 (0.0, 0.0,0.0)
        yAxis.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(Double.pi / 2))
        yAxis.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        
        axisNode.addChildNode(yAxis)
        
        
        
        let zAxis = SCNNode()
        zAxis.geometry = SCNCylinder(radius: CGFloat(0.005) , height: CGFloat(10.0))
        zAxis.position = SCNVector3 (0.0, 0.0,0.0)
        zAxis.rotation = SCNVector4(x: 0, y: 0, z: 1, w: Float(Double.pi / 2))
        zAxis.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        axisNode.addChildNode(zAxis)
        
        return axisNode
    }
}
