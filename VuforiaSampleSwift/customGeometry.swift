//
//  customGeometry.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 3/18/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SceneKit

class customGeometry :CLGeometry {

var vertices = [SCNVector3]()
var edges = [Int32]()
    func generateVertices()-> [SCNVector3]{
for x in -10 ..< 11 {
    for y in -10 ..< 11{
        let z = sin(Double(x))+sin(Double(y))
        let vertix = SCNVector3(x , y , Int(z))
        
        vertices.append(vertix)
    }
        }
        return vertices
    }
    
    func generateLines()-> [Int32]{
for x in 0..<vertices.count  {
    edges.append(Int32(x))
}
        return edges
    }

  lazy var GenerateGeometry : SCNGeometry = {
  return self.createGeometry(vertices:self.generateVertices(), indices:self.generateLines(), primitiveType:SCNGeometryPrimitiveType.line)
}()
    
    lazy var faces:SCNGeometry = {
        return self.createGeometry(
            vertices: self.generateVertices(), indices: self.generateLines(),
            primitiveType: SCNGeometryPrimitiveType.triangles)
    }()
    
    lazy var wireframe:SCNGeometry = {
        return self.createGeometry(
             vertices: self.generateVertices(), indices: self.generateLines(),
            primitiveType: SCNGeometryPrimitiveType.line)
    }()
}
