//
//  EquationObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/5/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class EquationObject: Object {
    
    dynamic var id : String = ""
    dynamic var equation : String = ""
    dynamic var x : Float = 0.0
    dynamic var y : Float = 0.0
    dynamic var z : Float = 0.0
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
