//
//  Course.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/16/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift


class Course{
   
    //attributes
    
    var id:String
    var name:String
    var category:String
    var year:String
    var startDate:Date
    var endDate:Date
    var bookTitle:String
    var lessons:Array<Lesson>
    var realm : Realm? = SetUpRealm.realm
   
    
    init(){
         id = ""
         name = ""
         category = ""
         year = ""
         startDate = Date()
         endDate = Date()
         bookTitle = ""
         lessons = Array<Lesson>()
        
    }
   
    func set_course()  {
        
        var c =  realm?.object(ofType: CourseObject.self, forPrimaryKey: self.id)
     
        if (c != nil){
            print("Course already exist")
        }
        else{
            
            c = CourseObject()
            c?.bookTitle = self.bookTitle
            c?.category = self.category
            c?.endDate = self.endDate
            c?.startDate = self.startDate
            c?.id = self.id
            c?.name = self.name
            
            try! realm?.write {
                realm?.add(c!)
                print("Course Added")
            }
        }
        
    }
    
    func get_course(CID : String) -> Course {
        
        let c =  realm?.object(ofType: CourseObject.self, forPrimaryKey: CID)

        self.id = (c?.id)!
        self.bookTitle = (c?.bookTitle)!
        self.category = (c?.category)!
        self.endDate = (c?.endDate)!
        self.startDate = (c?.startDate)!

        return self
    }
    
    func addLesson(L : Lesson) {
        
        let course =  realm?.object(ofType: CourseObject.self, forPrimaryKey: self.id)
        
        if(course != nil){
            
            let l =  realm?.object(ofType: LessonObject.self, forPrimaryKey: L.id)
            if(l != nil && !(course?.lessons.contains(l!))!){
                
                
                try! realm?.write {
                    l?.course = course
                    course?.lessons.append(l!)
                   
                    realm?.add(course! , update : true)
                }
                print("Lesson Added")
            }
            else{
                print("Lesson NOT Found")
            }
            
            
        }else{
            print("Course NOT Found")
        }       
}
    func getLessonArray() -> Array<Lesson> {
        
        let course =  realm?.object(ofType: CourseObject.self, forPrimaryKey: self.id)
        let lessonList = course?.lessons
        
        for lesson in lessonList!{
            let lessonObject = Lesson()
            lessonObject.id = lesson.id
            lessonObject.name = lesson.name
            lessonObject.number = lesson.number
            lessonObject.course = self
            self.lessons.append(lessonObject)
        }
        return self.lessons
        
    }

}
