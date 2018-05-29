//
//  ExerciseObject.swift
//  LearningSystem
//
//  Created by Rawan Abdullah on 2/25/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift


class ExerciseObject : Object {

    dynamic var id : String = ""
    dynamic var number : Int = 0
    dynamic var page : String = ""
    dynamic var imagePath : String = ""
    dynamic var question : String = ""

    dynamic var equation : EquationObject?
    dynamic var real_life : RealLifeObject?
    dynamic var homework : HomeworkObject?

    
    override class func primaryKey() -> String? {
        return "id"
    }


}

