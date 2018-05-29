//
//  SolutionObject.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/21/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class SolutionObject: Object {
    
    dynamic var progress : ProgressObject!
    dynamic var mark : Int = 0
    dynamic var image : NSData?
    dynamic var solution : String? = ""
    dynamic var exercise : ExerciseObject!
    
    public dynamic var compoundKey: String = ""

    dynamic var EID  = ""
    dynamic var PID  = ""
    
    func setCompoundEID(EID: String) {
        self.EID = EID
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundPID(PID: String) {
        self.PID = PID
        compoundKey = compoundKeyValue()
    }
       override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    override static func ignoredProperties() -> [String]{
        return ["EID","PID"]
    }
    
    func compoundKeyValue() -> String {
        return "\(EID)\(PID)"
    }
}
