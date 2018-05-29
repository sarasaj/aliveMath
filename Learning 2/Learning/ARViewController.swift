//
//  ViewController.swift
//  LearningSystem
//
//  Created by Rawan Abdullah on 2/22/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit
import RealmSwift

class ARViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //addHuman()
                var s1 = Student()
                s1.email="rawan@hotmail.com"
                s1.firstname="Razan"
                s1.lastname="Abdullah"
                s1.id="43201099"
                s1.password="123"

         let s2 = Student()
        s2.email="rawan@hotmail.com"
        s2.firstname="FERAS"
        s2.lastname="BIN SALMAN"
        s2.id="4445666"
        s2.password="123"
        
        
        let s3 = Student()
        s3.email="rawan@hotmail.com"
        s3.firstname="ALi"
        s3.lastname="Abdullah"
        s3.id="1003245"
        s3.password="123"
        
//        s1.set_student()
//        s2.set_student()
//        s3.set_student()
//        s3.remove_student()
        
//        s3.get_student()
//        print("============")
//        s3.update_student()
        print("============")
//        queryPeople()
        print("============")
        
        let t1 = Teacher()
        t1.firstname = "Ohood"
        t1.lastname = "AB"
        t1.email = "O@h.com"
        t1.id = "44300954101"
        t1.password = "123"
        
//        t1.set_teacher()
        let t2 = Teacher()
        t2.firstname = "Kholood"
        t2.lastname = "AB"
        t2.email = "K@h.com"
        t2.id = "100545"
        t2.password = "123"
        
//        t2.set_teacher()
        
//        var profile = Profile()
//       print((profile.check(id:"100545")))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    func addHuman()  {
//        let Mike = Human()
//        Mike.Age = 20
////        Mike.FirstName = "Sara"
////        Mike.LastName = "Jonson"
//        
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(Mike)
////            print("Added \(Mike.FirstName) to Realm")
//        }
//    }
    
//    func queryPeople()  {
//        let realm = try! Realm()
//        
//        let allPeople = realm.objects(StudentObject.self)
//        
//        // let adults = allPeople.filter("FirstName BEGINSWITH 'A'")
//        let sort = allPeople.sorted(byKeyPath: "id" , ascending: true)
//        
//        for person in allPeople {
//            print("\(person.firstname) is \(person.id) ")
//        }
//    }
}

