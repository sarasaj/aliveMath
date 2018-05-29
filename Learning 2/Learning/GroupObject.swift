//
//  GroupObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 2/27/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class GroupObject: Object {
    
    dynamic var groupnumber: String = ""
    dynamic var teacher : TeacherObject?
    let students = List<StudentObject>()
    dynamic var course : CourseObject?
    
    override class func primaryKey() -> String? {
        return "groupnumber"
    }

}
