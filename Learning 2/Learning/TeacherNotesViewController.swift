//
//  TeacherNotesViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherNotesViewController: UIViewController {

    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var hwSolution: UILabel!
    @IBOutlet weak var equation: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var mark: UILabel!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var save: UIButton!
    
    var progress = Progress()
    var lesson = Lesson()
    var group = Group()
    var solution = Solution()
    
    var StudentID : String = ""
    
    @IBAction func saveNote(_ sender: Any) {
        
        if(progress.addNote(Note: notes.text )){
            print("Note Added to Progress")
            notes.backgroundColor = UIColor.purple
        }
        else{
            print("Note NOT Added")
        }
    }
    override func viewDidLoad() {
        
        question.text = solution.question
        hwSolution.text = solution.solution
        equation.text = solution.exercise.equation.equation
        image.image = UIImage(data:(solution.image as NSData) as Data,scale:1.0)
        notes.text = progress.note
    
        
        progress = progress.getProgress(ProgressID: progress.compoundKey)
        
        let date = Date()
        solution.updateMark()
        switch date.compare(progress.homework.deadLine!) {
            
        case .orderedAscending:
            mark.text = "لم يتم رفع الدرجة المستحقة"
            break
            
        case .orderedDescending:
            mark.text = String(solution.mark) + "%"
            break
            
        case .orderedSame:
            mark.text = String(solution.mark) + "%"
            break
        }

        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector(("imageTapped:")))
        
            image.addGestureRecognizer(tapRecognizer)
        
        image.isUserInteractionEnabled = true
        
        
        super.viewDidLoad()
        print("Student id "+StudentID)
      
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Profile.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "backtohwex") {
            let ex = segue.destination as! StudentHWExerciesViewController;
            ex.progress = self.progress
            ex.progressID = self.progress.compoundKey
            ex.lesson = self.lesson
            ex.lessonID = self.lesson.id
            ex.group = self.group
            //ex.solution = self.solution
            
            
            
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    @IBAction func imageTapped(gestureRecognizer: UITapGestureRecognizer
        ) {
        let imageView = gestureRecognizer.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    


}
