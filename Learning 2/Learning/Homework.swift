//
//  Homework.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/15/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Homework{
    
    //attribute
    var id : Int!
    var lesson : Lesson?
    var exercieses : Array<Exercise>?
    var deadLine : Date?
    var group : Group!
    var realm : Realm? = SetUpRealm.realm

    
    init(){
       id = 0
        lesson = Lesson()
        exercieses = Array<Exercise>()
        deadLine = Date()
        group = Group()
    }
    
// when teacher get HW information only , NOT fixed in tha database
    func getHomework(HWID : Int)-> Homework {
        print("GET HW ")
        let hw =  realm?.object(ofType: HomeworkObject.self, forPrimaryKey: HWID)

        let lesson = realm?.object(ofType: LessonObject.self, forPrimaryKey: hw?.lesson.id)

        let L = Lesson()
        _ = Group()
        
        self.id = HWID
        self.deadLine = hw?.deadLine
        self.lesson = L.get_lesson(LID: (lesson?.id)!)

        return self
    }
    func getAllHW() -> Array<Homework> {
        print("IM HERE")
        var homeworkArray = Array<Homework>()
        let AllHW = realm?.objects(HomeworkObject.self)
        
        for homework in AllHW!{
            
            if(homework.group == nil){
                print("Insider if group == nil")
                var hw = Homework()
                print( homework.id )
                hw = hw.getHomework(HWID: homework.id)
                homeworkArray.append(hw)
            }
            
        }
        print("loop DONE")
        return homeworkArray
    }
    
    func addHomeworkByTeacher(homework : Homework)-> Bool {
        
        let h = HomeworkObject()
        
        let dbhw =  realm?.object(ofType: HomeworkObject.self, forPrimaryKey: homework.id)
        
        let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.group.groubnumber)

        try! realm?.write {
           
            h.id = (dbhw?.incrementID())!
            // ID in incremental
            self.id = h.id
            h.deadLine = self.deadLine
            h.group = group
            h.lesson = dbhw?.lesson
            h.exercieses = (dbhw?.exercieses)!
            realm?.add(h)

        }
        
        if(h.id != 0){
            
           return true
        }
        else{
           return false
        }
        
    }
    
    func addHomeworke() {
        
        let hw = HomeworkObject()
        
        let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.group.groubnumber)
        
        let lesson =  realm?.object(ofType: LessonObject.self, forPrimaryKey: self.lesson?.id)
        
        try! realm?.write {
            hw.id = self.id
            hw.lesson = lesson
            hw.group = group
            hw.deadLine = self.deadLine
            realm?.add(hw)

        }
        
    }
  
    func addExercise(E : Exercise) {
        
        let HW =  realm?.object(ofType: HomeworkObject.self, forPrimaryKey: self.id)
        
        if(HW != nil){
            
            let exercise =  realm?.object(ofType: ExerciseObject.self, forPrimaryKey: E.id)
            if(exercise != nil){
            
                
                try! realm?.write {
                    exercise?.homework = HW
                    HW?.exercieses.append(exercise!)

                }
                print("Exercise Added")
            }
            else{
                print("Exercise NOT Found")
            }
            
            
        }else{
            print("Course NOT Found")
        }
    }


    func updateDate(date : Date)->Bool {
        
        let HW = realm?.object(ofType: HomeworkObject.self, forPrimaryKey: self.id)

            try! realm?.write {

                HW?.deadLine = self.deadLine
                
                realm?.add(HW!, update:   true)
                print("HW DateUpdated")

        }
         return true
    }

}

