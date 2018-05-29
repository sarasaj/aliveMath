//
//  Solution.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/21/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Solution{
    
    var progress : Progress!
    var mark : Int!
    var image : NSData!
    var solution : String!
    var exercise : Exercise!
    var question : String!
    var realm : Realm? = SetUpRealm.realm
    let url = NSURL(string: "https://thumb.ibb.co/fAiSBQ/8235.png")!
    
    init(){
        progress = Progress()
        mark = 0
        solution = ""
        question = ""
        exercise = Exercise()

        
    }
  
    func updateMark( ) -> Int {
        if (solution.isEmpty) {return 0}
        var correct : String = exercise.equation.equation
        var percentage : Int = 0
        
        //trim any white spaces
        var fmcorrect = correct.replacingOccurrences(of: " ", with: "")
        var fmsolution = self.solution!.replacingOccurrences(of: " ", with: "")
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
            if(i == correctLength) {flag = false}
            else if(Correctchar[i]==solChar[i]){
                i = i+1
                print("i :", i)
            }else {
                let fi: Float = Float(i)
                let fcorrectLength: Float = Float(correctLength)
                var temp: Float = fi/fcorrectLength
                print ("temp 1", temp)
                temp = temp*100
                print ("temp 2", temp)
                percentage = Int(temp)
                
                print("percentage :", percentage)
                
                mark = percentage
                return percentage
            }
        }
        mark = 100
        return 100;

    }
    
    func insertSolution(progressID : String , exerciseID : String) -> Void {

        let e =  realm?.object(ofType: ExerciseObject.self, forPrimaryKey: exerciseID)
        let p =  realm?.object(ofType: ProgressObject.self, forPrimaryKey: progressID)
        let s = SolutionObject()
        
        let imgData = NSData(contentsOf: url as URL)
        try! realm?.write {
            s.image = imgData
            s.setCompoundEID(EID: (e?.id)!)
            s.setCompoundPID(PID: (p?.compoundKey)!)
            s.progress = p
            s.exercise = e
            realm?.add(s)
        }

    }
    func viewSolutions(progressID : String) -> Array<Solution>? {
        var solutionArray = Array<Solution>()
        
        let solutions = realm?.objects(SolutionObject.self)
        
        for solution in solutions!{
            let e =  realm?.object(ofType: ExerciseObject.self, forPrimaryKey: solution.exercise.id)
            let ex = Exercise().getExercise(EID: (e?.id)!)
            
            if(solution.progress.compoundKey == progressID){
                let s = Solution()
                s.mark = solution.mark
                s.exercise = ex
                s.solution = solution.solution
                s.exercise.equation.equation = solution.exercise.equation?.equation
                s.question = solution.exercise.question
                s.image = solution.image
                solutionArray.append(s)
            }
            else{
              // Do nothing
            }
        }
        return solutionArray
    }
    
    func insertSolutionByStudent(insertedSolution : String , progressID : String , exerciseID : String, URL : NSData) -> Void {
        print(exerciseID)
        
        let SID = exerciseID + progressID
        
        let solution =  realm?.object(ofType: SolutionObject.self, forPrimaryKey: SID)


                    try! realm?.write {
                        solution?.image = URL
                        solution?.solution = insertedSolution

                        solution?.mark = self.updateMark()

                        realm?.add(solution!, update: true)
                
                        print("Student updated solution")
                    
        }

    }

}
