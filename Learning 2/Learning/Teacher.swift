//
//  Teacher.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/15/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Teacher {
    
    //attributes

    var firstname:String
    var lastname:String
    var id:String
    var email:String
    var password:String
    var major:String
    var image : NSData!
    let url = NSURL(string: "https://image.ibb.co/ghZbo5/blank_profile_picture_973461_640.png")!
    var groups:Array<Group>?
    var realm : Realm? = SetUpRealm.realm
    public var description: String { return "Student Info : \n ID: \(id) \n Name: \(self.firstname) \(self.lastname) \n E-mail: \(self.email) \n Password: \(self.password)" }
    
    init(){
        firstname = ""
        lastname = ""
        id = ""
        email = ""
        password = ""
        major = ""
        image = NSData(contentsOf: NSURL(string: "https://thumb.ibb.co/fAiSBQ/8235.png")! as URL)
        groups = Array<Group>()

        

    }

    //functions
    
    //add techer (set teacher)
    func set_teacher(){
       
       var t =  realm?.object(ofType: TeacherObject.self, forPrimaryKey: self.id)
        
        let u = ProfileObject()
        
        let imgData = NSData(contentsOf: url as URL)
        
        if (t != nil){
            print("User already exist")
        }
            
        else{

            t = TeacherObject()
            t?.email = self.email
            t?.firstname = self.firstname
            t?.lastname = self.lastname
            t?.id = self.id
            t?.password = self.password
            t?.major = self.major
            t?.image = imgData
            u.password = self.password
            u.id = self.id

            try! realm?.write {
                //        let t = TeacherObject()
              
                realm?.add(t!)
                realm?.add(u , update : true)
                print("Teacher is added")
            }
            
        }

    }
    
    //get teacher
    func get_teacher(TID  : String)-> Teacher {
        print(TID)
        let t =  realm?.object(ofType: TeacherObject.self, forPrimaryKey: TID)


            self.firstname = (t?.firstname)!
            self.lastname = (t?.lastname)!
            self.email = (t?.email)!
            self.password = (t?.password)!
            self.major = (t?.major)!
            self.id = TID
            self.image = (t?.image)!
            print(self.description)
                      return self
      
    }
    
    //delete teacher
    func remove_teacher(){
        let t =  realm?.object(ofType: TeacherObject.self, forPrimaryKey: self.id)
        
        if (t == nil){
            print(" NOT Found")
        }
        else {
            
            try! realm?.write {
                realm?.delete(t!)
            }
            
            print("Found")
        }
    }
    
    //update teacher
    func update_teacher() -> Bool{
        let t : TeacherObject?
        
        t = realm?.object(ofType: TeacherObject.self, forPrimaryKey: self.id)
        
        
        
        if (t == nil)
        {
            //print(self.description)
            print(" NOT Found")
            return false
        }
        else{
            
            
            try! realm?.write {
                t!.email = self.email
                t!.firstname = self.firstname
                t!.lastname = self.lastname
                t!.password = self.password
                t!.major = self.major
              
                realm?.add(t!, update:   true)
                print("Found")
            }
            return true
        }
    }

    func getGroupsArray() -> Array<String> {
        var groupsArray : [String] = [""]
        var i:Int = 0
        let Groups = realm?.object(ofType: TeacherObject.self, forPrimaryKey:self.id)?.groups
        
        for group in Groups!{
            groupsArray.insert(group.groupnumber, at: i)
            i += 1
            print(group.groupnumber)
        }
        
        return groupsArray
    }
    
    func updateTeacherImage(newProfileImage : UIImage) {
        
        let imageData: NSData = UIImagePNGRepresentation(newProfileImage)! as NSData
        
        let t = realm?.object(ofType: TeacherObject.self, forPrimaryKey: self.id)
        
        try! realm?.write {
            t!.image = imageData
            realm?.add(t!, update:   true)
            
        }
    }

}


