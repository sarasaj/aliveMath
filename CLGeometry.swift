//
//  Geometry.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 3/18/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//
import SceneKit

class CLGeometry : NSObject {
    
    // Creates a geometry object from given vertex, index and type data
    internal func createGeometry(vertices:[SCNVector3], indices:[Int32], primitiveType:SCNGeometryPrimitiveType) -> SCNGeometry {
        
        // Computed property that indicates the number of primitives to create based on primitive type
        var primitiveCount:Int {
            get {
                switch primitiveType {
                case SCNGeometryPrimitiveType.line:
                    return indices.count / 2
                case SCNGeometryPrimitiveType.point:
                    return indices.count
                case  SCNGeometryPrimitiveType.triangles,
                     SCNGeometryPrimitiveType.triangleStrip:
                    return indices.count / 3
                default:
                    return -1
                }
            }
        }
        
        // Create the source and elements in the appropriate format
        let data = NSData(bytes: vertices, length: MemoryLayout<SCNVector3>.size * vertices.count)
        
        
       let vertexSource = SCNGeometrySource(data: data as Data, semantic: SCNGeometrySource.Semantic.vertex, vectorCount: vertices.count, usesFloatComponents: true, componentsPerVector: 3, bytesPerComponent:  MemoryLayout<Float>.size, dataOffset: 0, dataStride: MemoryLayout<SCNVector3>.size)
        
        let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count)
       
        let element = SCNGeometryElement(
            data: indexData as Data, primitiveType: primitiveType,
            primitiveCount: primitiveCount, bytesPerIndex: MemoryLayout<Int32>.size)
        
        return SCNGeometry(sources: [vertexSource], elements: [element])
    }
}
