//
//  Equation.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/5/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Equation{
    
    var id : String!
    var equation : String!
    var x : Float!
    var y : Float!
    var z : Float!
    var realm : Realm? = SetUpRealm.realm
    
    init(){
        id = ""
        equation = ""
        x = 0.0
        y = 0.0
        z = 0.0
        
    }
    
    func getEquation(){
        
        let e =  realm?.object(ofType: EquationObject.self, forPrimaryKey: self.id)
        if(e == nil){
            print("No Equation")
        }
        else{
          self.id = e?.id
            self.x = e?.x
            self.y = e?.y
            self.z = e?.z
            self.equation = e?.equation
        }
        //return self
    }
    
    func add() -> Bool {
        
         var e =  realm?.object(ofType: EquationObject.self, forPrimaryKey: self.id)
        
        if(e == nil){
            
            e = EquationObject()
            e?.id = self.id
            e?.equation = self.equation
            e?.x = self.x
            e?.y = self.y
            e?.z = self.z
            
            try! realm?.write {
                realm?.add(e!)
            }
            return true
        }
        else {
            return false
        }
        
    }

}
