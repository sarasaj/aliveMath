//
//  HomeworkObject.swift
//  LearningSystem
//
//  Created by Rawan Abdullah on 2/25/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class HomeworkObject : Object {

    dynamic var id : Int = 0
    dynamic var lesson : LessonObject!
    var exercieses = List<ExerciseObject>()
    dynamic var deadLine : Date!
    dynamic var group : GroupObject!

    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
       let realm = SetUpRealm.realm
       let x = (Int)((realm?.objects(HomeworkObject.self).last?.id)!)
        return x + 1
    }
}
