//
//  StudentObject.swift
//  LearningSystem
//
//  Created by Rawan Abdullah on 2/21/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class StudentObject : Object {
    
    
    /* What is all this Dynamic business? This attribute informs the Swift compiler that storage
    and implementation of aaproperty will be provided at runtime.*/
    
    dynamic var firstname:String = ""
    dynamic var lastname:String = " "
    dynamic var id:String = ""
    dynamic var email:String = ""
    dynamic var password:String = ""
    dynamic var image : NSData?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

//class ProgressObject : Object {
//    
//}
//
//class LessonObject : Object {
//     dynamic var id:String = ""
//}
//
//class GroupObject : Object {
//    
//}
//

