//
//  CourseObject.swift
//  LearningSystem
//
//  Created by Rawan Abdullah on 2/25/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class CourseObject : Object {

    dynamic var id:String = ""
    dynamic var name:String = ""
    dynamic var category:String = ""
    dynamic var year:String = ""
    dynamic var startDate:Date?
    dynamic var endDate:Date?
    dynamic var bookTitle:String = ""
    var lessons = List<LessonObject>()

    override class func primaryKey() -> String? {
        return "id"
    }

}

