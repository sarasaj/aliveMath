//
//  StudentSingleLessonViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class StudentHWExerciesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var lessNum: UILabel!
    @IBOutlet weak var lessonName: UILabel!
    var lessonID : String = ""
    var selected = 0
    var hwID : Int = 0
    
    var lesson = Lesson()
    var group = Group()
    //var solution = Solution()
    @IBOutlet weak var questionsTableView: UITableView!

    var progressID : String = ""
    var progressArray = Array<Progress>()
    var solutionsArray = Array<Solution>()
    
    var student = Student()
    var progress = Progress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("INSIDE")
        print(student.id)
        print(hwID)

        progressArray = progress.getStudentProgresses(SID: student.id)!
        for p in progressArray{
            if(p.homework.id == self.hwID){
                print("IF CONDITION")
                progress = p
                
            }
            else {
//                do nothing or remove from array
            }
        }
        
        questionsTableView.delegate = self
        questionsTableView.dataSource=self
        
        let solution = Solution()
        solutionsArray = solution.viewSolutions(progressID: progress.compoundKey)!
        
        
        var lesson = Lesson()
        progress = progress.getProgress(ProgressID: progress.compoundKey)
        lesson.id = (progress.homework.lesson?.id)!
        lesson = lesson.get_lesson(LID: lesson.id)
        print(lesson.description)
        lessNum.text = String(lesson.number)
        lessonName.text = lesson.name
        print("PLEASE PRINT ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return solutionsArray.count
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell=questionsTableView.dequeueReusableCell(withIdentifier: "markCell", for: indexPath) as! singleLessonMarksTableViewCell
        
        cell.question.text = solutionsArray[indexPath.row].question
        cell.equation.text = solutionsArray[indexPath.row].exercise.equation.equation
        cell.imageView?.image = UIImage(data:(solutionsArray[indexPath.row].image as NSData) as Data,scale:1.0)
        
        //only show mark when its publish time
        let date = Date()
        
        if (date > progress.homework.deadLine!){
            cell.mark.text = String(solutionsArray[indexPath.row].mark)
            
        }
        else {
            cell.mark.text = "لم يتم رصد الدرجة"
        }
        
        
        //------------------------------------------
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backTotechleson") {
            let singleLesson = segue.destination as! TeacherSingleLessonViewController;
            singleLesson.lesson.number = self.lesson.number
            singleLesson.lesson.name = self.lessonName.text!
            //Added this
            singleLesson.group = self.group
            singleLesson.hwID = self.hwID
            singleLesson.lesson.id = self.lesson.id
            
        }
        if (segue.identifier == "AddNote") {
            let note = segue.destination as! TeacherNotesViewController;
            note.progress = self.progress
            print("prog",self.progress.compoundKey)
            
            note.solution = self.solutionsArray[selected]
            print("self.solutionsArray[selected]:",self.solutionsArray[selected].question)
            
            print("hw ex selected :",selected)
            note.StudentID = self.student.id
            
            note.group = self.group
         
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected lesson cell number: \(indexPath.row)!")
        
        selected=indexPath.row
        self.performSegue(withIdentifier: "AddNote", sender: indexPath);
    }
    
}
