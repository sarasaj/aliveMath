//
//  Progress.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/16/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Progress{
    
    var compoundKey : String
     var note:String
     var mark:Int
     var student:Student
     var course:Course
     var homework:Homework
    var realm : Realm? = SetUpRealm.realm
    
    init(){
         compoundKey = ""
         note = ""
         mark = 0
         student = Student()
         course = Course()
         homework = Homework()

     
    }

    func getProgress(ProgressID : String) -> Progress {
        
        let progress = realm?.object(ofType: ProgressObject.self, forPrimaryKey: ProgressID)
        
        let c =  realm?.object(ofType: CourseObject.self, forPrimaryKey: progress?.course.id)
        
        let hw =  realm?.object(ofType: HomeworkObject.self, forPrimaryKey: progress?.homework.id)
        
        let C = Course()
        let HW = Homework()
        
        self.course = C.get_course(CID: (c?.id)!)
        self.homework = HW.getHomework(HWID: (hw?.id)!)
 
        self.compoundKey = ProgressID
        self.note = (progress?.note)!
        self.mark = (progress?.mark)!
        print("********************")
        print(progress?.note)
        print("********************")
        print(progress?.mark)
        return self
    }
    // create new progress per homework
    func uploadSolution(exercises : Array<Exercise>, solution : Array<String>?){
        
        let progress = ProgressObject()
        
        let s = realm?.object(ofType: StudentObject.self, forPrimaryKey: self.student.id)
        
        let c =  realm?.object(ofType: CourseObject.self, forPrimaryKey: self.course.id)
        
        let HW =  realm?.object(ofType: HomeworkObject.self, forPrimaryKey: self.homework.id)
        
        var noOfEx = 0
        var totalMark = 0
        var progressMark = 0
        
        for exercise in exercises{
            
            self.mark = mark + updateMark(correct: exercise.getEquation() , solution: (solution?[noOfEx])!)
            totalMark = totalMark + mark
            noOfEx = noOfEx + 1
            
            progressMark = totalMark/noOfEx
        }
        

        try! realm?.write {
            
            //set progress PK
            progress.setCompoundCId(CID: self.course.id)
            progress.setCompoundHId(HID: self.homework.id)
            progress.setCompoundSID(SID: self.student.id)
          
            progress.course = c!
            progress.student = s!
            progress.homework = HW!
            progress.mark = progressMark

            realm?.add(progress)
        }

        
        if(progress.compoundKey != ""){
            // progress is added to DB
            // add solutions objects to DB 
            for exercise in progress.homework.exercieses{
                var solution = Solution()
                solution.insertSolution(progressID: progress.compoundKey, exerciseID: exercise.id)
            }
        }
        else{
           print("Solution objects NOT added")
        }
        
    }
    func getStudentProgresses(SID : String) -> Array<Progress>? {

        var studentProgressArray = Array<Progress>()

        let studentProgresss = realm?.objects(ProgressObject.self)


        for progress in studentProgresss!{
            if(progress.student.id == SID){
                let p = Progress()
                p.compoundKey = progress.compoundKey
                p.course.id = progress.course.id
                p.homework.id = progress.homework.id
                p.note = progress.note
                studentProgressArray.append(p)
            }
            else{
               // Do nothing
            }
        
        }

        return studentProgressArray
    }
    
    func addNote(Note : String) -> Bool {

        let progress = realm?.object(ofType: ProgressObject.self, forPrimaryKey: self.compoundKey)

        try! realm?.write {
            progress?.note = Note
            realm?.add(progress!, update: true)
        }
        
        if(progress?.note != nil){
            return true
        }else{
          return false
        }
  
    }
    
    
    //this function must compare and return result from 0 to 100 ( NOT just 0 and 100
    func updateMark(correct : String , solution : String?) -> Int {
        
        var percentage : Int = 0
        
        //trim any white spaces
        var fmcorrect = correct.replacingOccurrences(of: " ", with: "")
        var fmsolution = solution!.replacingOccurrences(of: " ", with: "")
        print("fmcorrect :", fmcorrect)
        print("fmsolution :", fmsolution)
        
        //get length
        let correctLength : Int = correct.characters.count
        print("correctLength :", correctLength)
        
        //char array
        
        var Correctchar =  Array(fmcorrect.characters)
        var  solChar = Array(fmsolution.characters)
        
        //compare char by char
        var i : Int = 0
        var flag : Bool = true
        
        while (flag){
            if(i == correctLength ) {flag = false}
            else if(Correctchar[i]==solChar[i]){
                i = i+1
                print("i :", i)
            }else {
                percentage = ((i/correctLength)*100)
                print("percentage :", percentage)
                return percentage
            }
        }
        return 100;
        
    }
    
}

