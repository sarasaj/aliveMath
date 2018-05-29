//
//  RealLifeObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/5/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class RealLifeObject: Object {
    
    dynamic var id : String = ""
    dynamic var videoPath : String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
