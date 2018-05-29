//
//  ProfileObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/12/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileObject: Object {
    
    dynamic var id : String = ""
    dynamic var password : String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
