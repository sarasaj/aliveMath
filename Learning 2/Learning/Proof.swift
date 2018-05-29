//
//  Proof.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/10/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Proof {
    
    var id : String
    var title : String
    var category : String
    var videoPath : String
    var imagePath : String
    var realm : Realm? = SetUpRealm.realm
    
    init(){
         id = ""
         title = ""
         category = ""
         videoPath = ""
         imagePath = ""
        
    }
    
    func add() -> Bool {
        
        var p =  realm?.object(ofType: ProofObject.self, forPrimaryKey: self.id)
        
        if(p == nil){
            p = ProofObject()
            try! realm?.write {
                
                
                p?.id = self.id
                p?.category = self.category
                p?.title = self.title
                p?.videoPath = self.videoPath
                p?.imagePath = self.imagePath
                
                realm?.add(p!)
            }
            return true
        }
        else{
            return false
        }
        
    }
    
    func delete() -> Bool {
        
        let p =  realm?.object(ofType: ProofObject.self, forPrimaryKey: self.id)
        
        if(p != nil){
            
            try! realm?.write {
                realm?.delete(p!)
            }
            return true
        }
        else{
            return false
        }
        
    }
    
    func load() -> String {
        let notFound = "Not Found"
        let p =  realm?.object(ofType: ProofObject.self, forPrimaryKey: self.id)
        
        self.id = (p?.id)!
        self.title = (p?.title)!
        self.category = (p?.category)!
        self.videoPath = (p?.videoPath)!
        self.imagePath = (p?.imagePath)!

        if(p != nil){
            
            return self.videoPath
        }
        else{
            return notFound
        }
    }

}
