//
//  LessonObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/5/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class LessonObject: Object {
    
    dynamic var id:String = ""
    dynamic var name:String = ""
    dynamic var number:Int = 0
    dynamic var course:CourseObject?
    var exercieses = List<ExerciseObject>()

    
    override class func primaryKey() -> String? {
        return "id"
    }
}
