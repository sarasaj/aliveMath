//
//  LessinObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/9/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class LessinObject: Object {
    
    
    dynamic var id:String?
    dynamic var name:String?
    dynamic var number:Int?
    dynamic var course:CourseObject?
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
