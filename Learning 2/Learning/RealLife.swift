//
//  RealLife.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/5/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class RealLife{
    
     var id : String!
     var videoPath : String!
     var realm : Realm? = SetUpRealm.realm
    
    
    init(){
        
        id = ""
        videoPath = ""

    }
    
    func getReallife() -> Void {
        let r =  realm?.object(ofType: RealLifeObject.self, forPrimaryKey: self.id)
        
        if(r != nil){
           self.id = r?.id
            self.videoPath = r?.videoPath
        }
        else {
            print("Realm Life Not Found")
        }
    }
    func add() -> Bool {
        
        var v =  realm?.object(ofType: RealLifeObject.self, forPrimaryKey: self.id)
        
        if(v == nil){
            v = RealLifeObject()
            
            try! realm?.write {
                
                v?.id = self.id
                v?.videoPath = self.videoPath
                realm?.add(v!)
            }
            return true
        }
        else{
            return false
        }
    }
    
    func delete() -> Bool {
        
        let v =  realm?.object(ofType: RealLifeObject.self, forPrimaryKey: self.id)
        
        if(v != nil){
            
            try! realm?.write {
                realm?.delete(v!)
            }
            return true
        }
        else{
            return false
        }
        
    }
    
    func load() -> String {
        let notFound = "Not Found"
        let v =  realm?.object(ofType: RealLifeObject.self, forPrimaryKey: self.id)
        
        if(v != nil){
            
          return self.videoPath
        }
        else{
            return notFound
        }
    }

}
