//
//  ProgressObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/10/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class ProgressObject: Object {
 
    dynamic var note:String = ""
    dynamic var mark:Int = 0
    dynamic var student:StudentObject! = StudentObject()
    dynamic var course:CourseObject!
    dynamic var homework:HomeworkObject!

    dynamic var SID  = ""
    dynamic var CID  = ""
    dynamic var HID  = 0
  
    func setCompoundSID(SID: String) {
        self.SID = SID
        compoundKey = compoundKeyValue()
    }

    func setCompoundCId(CID: String) {
        self.CID = CID
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundHId(HID: Int) {
        self.HID = HID
        compoundKey = compoundKeyValue()
    }
    public dynamic var compoundKey: String = ""
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    override static func ignoredProperties() -> [String]{
        return ["SID","CID","HID"]
    }

    func compoundKeyValue() -> String {
        return "\(SID)\(CID)\(HID)"
    }
}

// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }

