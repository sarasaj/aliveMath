//
//  Exercies.swift
//  LearningEnviroment
//
//  Created by Rawan Abdullah on 2/15/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise{
    
    //attribute
    var id : String
    var number : Int
    var page : String
    var imagePath : String
    var image: UIImageView!
    var question : String
//    var plot : Plot
    var homework: Homework
    var equation : Equation
    var real_life : RealLife
    var realm : Realm? = SetUpRealm.realm
    
    init(){
        id = ""
        number = 0
        page = ""
        imagePath = ""
        question = ""
//        plot = Plot()
        equation = Equation()
        real_life = RealLife()
        homework = Homework()
      
    }

    func getExercise(EID : String) -> Exercise {
        let ex = realm?.object(ofType: ExerciseObject.self, forPrimaryKey: EID)
        
        self.id = EID
        self.number = (ex?.number)!
        self.page = (ex?.page)!
        self.question = (ex?.question)!
        
        return self
    }
    //functions
    func getEquation() -> String{
        let e =  realm?.object(ofType: ExerciseObject.self, forPrimaryKey: self.id)
        return (e?.equation?.equation)!
        
    }
    
    func setExercise() -> Void {
        // return all objects
        let eq =  realm?.object(ofType: EquationObject.self, forPrimaryKey: equation.id)


        let r =  realm?.object(ofType: RealLifeObject.self, forPrimaryKey: real_life.id)

        
        var e =  realm?.object(ofType: ExerciseObject.self, forPrimaryKey: self.id)
      
        
        if (e != nil){
            print("Exercise already exist")
        }
        else{
            
            e = ExerciseObject()
            e?.id = self.id
            e?.page = self.page
            e?.number = self.number
            e?.imagePath = self.imagePath
            e?.equation = eq
            e?.real_life = r
            e?.question = self.question

            try! realm?.write {
                
                realm?.add(e!)
                print("Excersie is added")
            }
            
        }
    }

}
