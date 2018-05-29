//
//  TeacherSingleGroupViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherSingleGroupViewController: UIViewController {

    @IBOutlet weak var groupNumber: UILabel!
    @IBOutlet weak var numberOfStudent: UILabel!
    @IBOutlet weak var AddHw: UIButton!
    
    @IBOutlet weak var reviseAnswers: UIButton!
    var group = Group()
 
//    var groupID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupNumber.text = group.groubnumber
        numberOfStudent.text = "\(group.studentCount())"        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "revise") {
            let lesson = segue.destination as! TeacherLessonsViewController;
            
    
            lesson.group = self.group
            
        }
        if (segue.identifier == "backTogroups") {
            let groups = segue.destination as! TeacherGroupsViewController;
            groups.teacher = self.group.getTeacher()
        }
        
        if (segue.identifier == "newHw") {
            let newHw = segue.destination as! addHomeworkViewController;
            print("the F group : " + "\(self.group)")
            newHw.group = self.group
            
        }
    }
    

}
