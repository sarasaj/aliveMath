//
//  Group.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/16/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Group{
    
    //attribute
    
    var groubnumber:String = ""
    var teacher:Teacher!
    var course:Course!
    var students:Array<Student>!
    var realm : Realm? = SetUpRealm.realm
    
    public var description: String { return "Group # : \(groubnumber) \n "}
    
    init(){
     groubnumber = ""
     students = Array<Student>()
        
    }

   //functions
    func get_group(GID : String) -> Group {
        let g =  realm?.object(ofType: GroupObject.self, forPrimaryKey: GID)
        
        let teacher = realm?.object(ofType: TeacherObject.self, forPrimaryKey: g?.teacher?.id)
        
        let T = Teacher()
        
        self.teacher = T.get_teacher(TID: (teacher?.id)!)
        self.groubnumber = GID
        return self
        
    }
    func setgroup(){
        
        var group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.groubnumber)
        
        if(group == nil){
            group = GroupObject()
            group?.groupnumber = self.groubnumber

            try! realm?.write {
                try! realm?.add(group!)
            }
            //return true
            print("Goup Added")
        }
        else{
           // return false
            print("Group NOT Added")
        }
    }
    
    func studentCount() -> Int {
        
         let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.groubnumber)
        print(group?.students.count)
        return (group?.students.count)!
        
    }
    func addTeacherToGroup(t1 : Teacher) -> Void{
       
      //  let teacherID = self.teacher?.id
        let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.groubnumber)
        
        if(group != nil){
            
            if(group?.teacher == nil){
                let t =  realm?.object(ofType: TeacherObject.self, forPrimaryKey: t1.id)
                if(t != nil){
//                    let teacherG = Teacher()
//                    teacherG.id = (t?.id)!
//                    teacherG.get_teacher()
                    
                    try! realm?.write {
                        t?.groups.append(group!)
                        group?.teacher = t
                        try! realm?.add(group! , update : true)
                    }
                    
                }
            }
            else{
                print("Group has Teacher")
            }
            
        }else{
            print("Group NOT Found")
        }
       
    }
    
    func addStudenToGroup(s1 : Student) -> Void{
        
       
        let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.groubnumber)
        
        if(group != nil){
         
                let s =  realm?.object(ofType: StudentObject.self, forPrimaryKey: s1.id)
                if(s != nil){
   
                    
                    try! realm?.write {
                        group?.students.append(s!)
                        try! realm?.add(group! , update : true)
                    }
                  print("Student Added")
                }
                else{
                    print("Student NOT Found")
            }
            
            
        }else{
            print("Group NOT Found")
        }
        
    }

    func addCourseToGroup(c1 : Course) -> Void{
        
        //  let teacherID = self.teacher?.id
        let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.groubnumber)
        
        if(group != nil){
            
            if(group?.course == nil){
                let c =  realm?.object(ofType: CourseObject.self, forPrimaryKey: c1.id)
                if(c != nil){

                    
                    try! realm?.write {
                        group?.course = c
                        try! realm?.add(group! , update : true)
                    }
                    
                }
            }
            else{
                print("Group has Course")
            }
            
        }else{
            print("Group NOT Found")
        }
        
    }
    
    func getTeacher() -> Teacher {
        let tchrObject = Teacher()
        let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.groubnumber)
        
        let teacherID = group?.teacher?.id
//        
//        let teacher =  realm.object(ofType: TeacherObject.self, forPrimaryKey: teacherID)
        
        tchrObject.get_teacher(TID: teacherID!)
        return tchrObject
        
    }
    func getStudents()-> Array<Student> {
        let group =  realm?.object(ofType: GroupObject.self, forPrimaryKey: self.groubnumber)

        var studentArray = Array<Student>()
            for student in (group?.students)!{
                
                let s1 =  realm?.object(ofType: StudentObject.self, forPrimaryKey: student.id)
                let studentG = Student()
                studentG.id = (s1?.id)!
                studentG.get_student()

                studentArray.append(studentG)
               // print(studentG.description)
               // print("==========")
            }
            
    
//        }
            return studentArray
    }

}

