//
//  mesh.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 3/22/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation
import SceneKit

class meshGeometry: SCNNode {
    
    var meshVertices = [SCNVector3]()
    var normals = [SCNVector3]()
    var triangleIndices = [UInt16]()
    var a = 1.0 , c = 0.0 , b = 1.0
    var verticesPerSide = 0
    var equation = String()
    var equationType = Int()
    
    /** Actual length of the terrain, configured on initialization. */
    var sideLength = 0.0
    
    
    init(Resolution: Int , sideLength: Double )
    {
        super.init()
        
        self.verticesPerSide = Resolution
        self.sideLength = sideLength
        self.equationType = 1
        
        self.populateDataBuffersWithStartingValues()
        self.configureGeometry()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        
        self.populateDataBuffersWithStartingValues()
        self.configureGeometry()
        
    }
    
    func setA (a : Double)
    {
        self.a = a
    }
    func setB (b : Double)
    {
        self.b = b
    }
    
    func setC (c: Double)
    {
        self.c = c
    }
    
    
    
    func equation(code: Int, x: Double , y: Double) -> Double {
        switch(code){
        case 1: return a * sin(b * x + c) + a * sin(b * y + c)
        case 2: return Swift.abs( cos(x) * sin(y))
        case 3: return (pow(y,2)/16) - (pow(x,2)/25)
        case 4: return sin(1.61803399 + sqrt(pow(x,2) + pow(y,2)))
        default: return -1.0
        }
    }
    
    
    func populateDataBuffersWithStartingValues()
    {
        
        let totalVertices = verticesPerSide * verticesPerSide;
        let squaresPerSide = (verticesPerSide - 1);
        let totalSquares = squaresPerSide * squaresPerSide;
        let totalTriangles = totalSquares * 2;
        
        for  i in 0 ..< totalVertices {
            let ix = i % verticesPerSide
            let iy = i / verticesPerSide
            
            let ixf = (Double(ix) / Double((verticesPerSide - 1)))
            let iyf = (Double(iy) / Double((verticesPerSide - 1)))
            let  x = ixf * Double(sideLength)
            let  y = iyf * Double(sideLength)
            
            /*  Create vertices */
            
            
            let  vertexZDepth = equation( code: self.equationType , x : x , y: y)
            meshVertices.insert(SCNVector3(x, y, Double(vertexZDepth)), at: i)
            
            /*  Create normals for each vertex */
            normals.insert(SCNVector3(0, 0, 1) , at: i)
            /*  Create texture coords (an X,Y pair for each vertex) */
            
        }
        
        for var i in 0 ..< totalTriangles {
            /*  Define the triangles that make up the terrain mesh */
            let squareIndex = (i / 2)
            let squareX = squareIndex % squaresPerSide
            let squareY = squareIndex / squaresPerSide
            
            let vPerSide = Int(verticesPerSide)
            let toprightIndex = ((squareY + 1) * vPerSide) + squareX + 1
            let topleftIndex = toprightIndex - 1
            let bottomleftIndex = toprightIndex - vPerSide - 1
            let bottomrightIndex = toprightIndex - vPerSide
            
            let i1 = i * 3;
            
            triangleIndices.insert(UInt16(toprightIndex ), at:i1)
            triangleIndices.insert(UInt16(topleftIndex),at:i1+1)
            triangleIndices.insert(UInt16(bottomleftIndex), at:i1+2)
            
            triangleIndices.insert(UInt16(toprightIndex),at:i1+3)
            triangleIndices.insert(UInt16(bottomleftIndex),at:i1+4)
            triangleIndices.insert(UInt16(bottomrightIndex),at:i1+5)
            
            i = i+2
        }
    }
    
    
    func configureGeometry()
    {
        
        let totalVertices = verticesPerSide * verticesPerSide;
        let squaresPerSide = (verticesPerSide - 1);
        let totalSquares = squaresPerSide * squaresPerSide;
        let totalTriangles = totalSquares * 2;
        
        let vertexSource = SCNGeometrySource(vertices: meshVertices , count:totalVertices)
        
        let normalSource = SCNGeometrySource(normals:normals , count:totalVertices)
        
        let indexData = NSData(bytes: triangleIndices , length: MemoryLayout<UInt16>.size * totalTriangles * 3)
        let element = SCNGeometryElement(data:indexData as Data , primitiveType:SCNGeometryPrimitiveType.triangles
            ,  primitiveCount:totalTriangles, bytesPerIndex:MemoryLayout<UInt16>.size)
        
        geometry = SCNGeometry(sources:[vertexSource, normalSource],  elements:[element])
        
        self.geometry = geometry;
    }
}
