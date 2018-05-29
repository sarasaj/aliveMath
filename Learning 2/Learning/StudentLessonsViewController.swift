//
//  StudentLessonsViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class StudentLessonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var lessonsTable: UITableView!
    
    var student = Student()
    var progressArray = Array<Progress>()
    var studentProgs : Int = 0
    
    override func viewDidLoad() {
        print("S LEESONs VIEW CONTROLLER")
        super.viewDidLoad()

        lessonsTable.delegate = self
        lessonsTable.dataSource = self
        
        let SID = student.id

        let progress = Progress()
        
        progressArray = progress.getStudentProgresses(SID: SID)!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.progressArray.count;
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
      
        let cell=lessonsTable.dequeueReusableCell(withIdentifier: "hwCell", for: indexPath) as! StudentLessonsTableViewCell
       
        cell.progressID = progressArray[indexPath.row].compoundKey
        cell.homeworkID.text = String(progressArray[indexPath.row].homework.id)
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stSinglLess") {
            let ssl = segue.destination as! StudentSingleLessonViewController;
            print("CLICKED ON")
          print(progressArray[studentProgs].compoundKey)
            ssl.progressID = progressArray[studentProgs].compoundKey
            ssl.progress = progressArray[studentProgs]
            ssl.student=self.student
        }
        if (segue.identifier == "backToStdProfile") {
            let StdProfile = segue.destination as! StudentProfileViewController;
            
            StdProfile.student =  self.student

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        studentProgs=indexPath.row
    }
}
