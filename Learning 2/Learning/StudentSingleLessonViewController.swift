//
//  StudentSingleLessonViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class StudentSingleLessonViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var lessNum: UILabel!
    @IBOutlet weak var lessonName: UILabel!
    @IBOutlet weak var questionsTableView: UITableView!
    
    
    var lessonID : String = ""
    var selected = 0
    var progressID : String = ""
    
    var solutionsArray = Array<Solution>()
    
    var student = Student()
    var progress = Progress()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        questionsTableView.delegate = self
        questionsTableView.dataSource=self
        
        let solution = Solution()
        solutionsArray = solution.viewSolutions(progressID: progressID)!
        
        for sol in solutionsArray {
            sol.updateMark()
        }
        

        var lesson = Lesson()
        progress = progress.getProgress(ProgressID: progress.compoundKey)
        lesson.id = (progress.homework.lesson?.id)!
        lesson = lesson.get_lesson(LID: lesson.id)
        print(lesson.description)
        lessNum.text = String(lesson.number)
        lessonName.text = lesson.name
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
        
        switch date.compare(progress.homework.deadLine!){
        case .orderedAscending     :
            cell.mark.text = "not set yet"
            break
        case .orderedDescending    :   print("Date A is later than date B")
        cell.mark.text = String(solutionsArray[indexPath.row].mark)
        
            break
        case .orderedSame          :   print("The two dates are the same")
            break
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backTostdLessons") {
            let lessons = segue.destination as! StudentLessonsViewController;
            lessons.student=self.student
        }
        if (segue.identifier == "expandSolution") {
            let submit = segue.destination as! StudentSubmitHWViewController;
            
            submit.progress = self.progress
            submit.solution = self.solutionsArray[selected]
            submit.student = self.student
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected lesson cell number: \(indexPath.row)!")
        
        selected=indexPath.row
    }

}
