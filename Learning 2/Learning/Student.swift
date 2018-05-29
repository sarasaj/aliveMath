//
//  Student.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/15/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


class Student {
    
    //attributes
    
    var firstname:String
    var lastname:String
    var id:String
    var email:String
    var password:String
    
    var image : NSData!
    let url = NSURL(string: "https://image.ibb.co/ghZbo5/blank_profile_picture_973461_640.png")!
   
    public var realm :Realm? = SetUpRealm.realm

    
    //functions
    
    //constructor
     init (){
        firstname = ""
        lastname = ""
        id = ""
        email = ""
        password = ""
    }

    func set_student() -> Void {
        
        
        
        //        obj?.fn() calls fn member function if the object isn't null, otherwise doesn't do anything.
        //
        //        obj!.fn() on the other hand asserts that obj isn't null, and calls fn. If the object is null, you get an exception.
        //
        //        So it's a difference in assertiveness: you either ask or simply claim the nullable property of a nullable object.

        var s =  self.realm?.object(ofType: StudentObject.self, forPrimaryKey: self.id)
        
        let u = ProfileObject()
        
        let imgData = NSData(contentsOf: url as URL)
        
        if (s != nil){
            print("User already exist")
        }
        else{
            
            s = StudentObject()
            s?.email = self.email
            s?.firstname = self.firstname
            s?.lastname = self.lastname
            s?.id = self.id
            s?.password = self.password
            s?.image = imgData
            u.password = self.password
            u.id = self.id
            
            try! realm?.write {
                //        let t = TeacherObject()
                
                realm?.add(s!)
                realm?.add(u , update : true)
                print("Student is added")
            }
            
        }
        

    }
    //get student
    func get_student() {
        
        let s =  realm?.object(ofType: StudentObject.self, forPrimaryKey: self.id)

        if (s == nil)
        {
           //print(self.description)
            print(" NOT Found")
        }
            
        else {
            self.firstname = (s?.firstname)!
            self.lastname = (s?.lastname)!
            self.email = (s?.email)!
            self.password = (s?.password)!
            self.image = (s?.image)!
           
            print("Found")
        }
    }
    
    //delete student
    func remove_student(ID : String){
        
        let s =  realm?.object(ofType: StudentObject.self, forPrimaryKey: ID)

            try! realm?.write {
                realm?.delete(s!)
            }
    }
    
    //update student
    func update_student() ->Bool{
        let s : StudentObject?

       s = realm?.object(ofType: StudentObject.self, forPrimaryKey: self.id)


        
        if (s == nil)
        {
            //print(self.description)
            print(" NOT Found")
            return false
        }
        else{

            
            try! realm?.write {
                s!.email = self.email
                s!.firstname = self.firstname
                s!.lastname = self.lastname
                s!.password = self.password
                realm?.add(s!, update:   true)
                print("Found")
                
            }
            return true
        }
    }
    func updateStdImage(newProfileImage : UIImage) {
        
         let imageData: NSData = UIImagePNGRepresentation(newProfileImage)! as NSData
        
        let s = realm?.object(ofType: StudentObject.self, forPrimaryKey: self.id)
        
        try! realm?.write {
            s!.image = imageData
            realm?.add(s!, update:   true)
            
        }
    }
    
}


