//
//  PlotObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/5/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class PlotObject: SCNScene {
    
    init (view: VuforiaEAGLView) {
        super.init()
        
        let axisNode = createAxis()
        self.rootNode.addChildNode(axisNode)
        
        let lightNode = createLight(type:.omni , color:UIColor.lightGray)
        lightNode.position = SCNVector3(x:0, y:10, z:10)
        self.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = createLight(type:.ambient , color:UIColor.darkGray)
        self.rootNode.addChildNode(ambientLightNode)
        
        let planeNode = SCNNode()
        planeNode.name = "plane"
        planeNode.geometry = SCNPlane(width: 247.0/view.objectScale, height: 173.0/view.objectScale)
        planeNode.position = SCNVector3Make(0, 0, -1)
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = UIColor.clear
        planeMaterial.transparency = 0.6
        planeNode.geometry?.firstMaterial = planeMaterial
        self.rootNode.addChildNode(planeNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        xAxis.geometry = SCNCylinder(radius: CGFloat(0.02) , height: CGFloat(5.0))
        xAxis.position = SCNVector3 (0.0, 0.0,0.0)
        xAxis.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(M_PI / 2))
        xAxis.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        axisNode.addChildNode(xAxis)
        
        
        let yAxis = SCNNode()
        yAxis.geometry = SCNCylinder(radius: CGFloat(0.02) , height: CGFloat(5.0))
        yAxis.position = SCNVector3 (0.0, 0.0,0.0)
        yAxis.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI / 2))
        yAxis.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        
        axisNode.addChildNode(yAxis)
        
        
        
        let zAxis = SCNNode()
        zAxis.geometry = SCNCylinder(radius: CGFloat(0.02) , height: CGFloat(5.0))
        zAxis.position = SCNVector3 (0.0, 0.0,0.0)
        zAxis.rotation = SCNVector4(x: 0, y: 0, z: 1, w: Float(M_PI / 2))
        zAxis.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        axisNode.addChildNode(zAxis)
        
        return axisNode
    }    
    
    // Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
