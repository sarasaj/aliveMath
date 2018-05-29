//
//  Lesson.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/16/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Lesson{
    
    var id:String
    var name:String
    var number:Int
    var course:Course
    var exercieses : Array<Exercise>?
    
    var realm : Realm? = SetUpRealm.realm
    public var description: String { return "Lesson Info : \n ID: \(self.id) \n Name: \(self.name)\n Number: \(self.number) \n Course: \(self.course.id)" }
    
    
    init(){
        id = ""
        name = ""
        number = 0
        course = Course()
       
    }
    
    func set_lesson() -> Void  {
        
        var l =  realm?.object(ofType: LessonObject.self, forPrimaryKey: self.id)
        
        if (l != nil){
            print("Lesson already exist")
        }
        else{
            
            l = LessonObject()
            l?.id = self.id
            l?.name = self.name
            l?.number = self.number
            
            
            try! realm?.write {
                realm?.add(l!)
                print("Lesson Added")
            }
        }

      
//        course id for lesson will be added when lesson is added to course
//        l.course?.id = self.course.id

     
    }
    
    func get_lesson(LID : String) -> Lesson {
        let l =  realm?.object(ofType: LessonObject.self, forPrimaryKey: LID)
        
         let c =  realm?.object(ofType: CourseObject.self, forPrimaryKey: l?.course?.id)

        let C = Course()
        self.id = (l?.id)!
        self.name = (l?.name)!
        self.number = (l?.number)!
        self.course = C.get_course(CID: (c?.id)!)
        
        
//            print(self.description)
        print("Lesson ID : "+(l?.id)!)
        
//        }
        return self
    }
  
    
    func addExercise(E : Exercise) {
        
        let l =  realm?.object(ofType: LessonObject.self, forPrimaryKey: self.id)
        
        if(l != nil){
            
            let exercise =  realm?.object(ofType: ExerciseObject.self, forPrimaryKey: E.id)
            if(exercise != nil){
                
                
                try! realm?.write {
                    l?.exercieses.append(exercise!)
                    
                }
                print("Exercise Added to Lesson")
            }
            else{
                print("Exercise NOT Found")
            }
            
            
        }else{
            print("Lesson NOT Found")
        }
    }
    
}

