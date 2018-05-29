//
//  TeacherObject.swift
//  LearningSystem
//
//  Created by Rawan Abdullah on 2/25/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class TeacherObject : Object {

    dynamic var firstname:String = ""
    dynamic var lastname:String = ""
    dynamic var id: String = ""
    dynamic var email:String = ""
    dynamic var password:String = ""
    dynamic var major:String = ""
    dynamic var image : NSData?
    var groups = List<GroupObject>()

    override class func primaryKey() -> String? {
        return "id"
    }
}

