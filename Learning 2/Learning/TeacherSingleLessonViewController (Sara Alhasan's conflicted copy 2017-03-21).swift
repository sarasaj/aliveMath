//
//  TeacherSingleLessonViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherSingleLessonViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var lessonNumber: UILabel!
    @IBOutlet weak var lessonTitle: UILabel!
    @IBOutlet weak var studentsTableView: UITableView!
    var lesson = Lesson()
    var group = Group()
    var selected=0
    var studentName : [String] = [""]
    var studentID : [String] = [""]
    var i : Int = 0
    var StdPrgresses : Array<Progress> = []
    

    override func viewDidLoad() {
        
        lessonNumber.text = "\(lesson.number)"
        lessonTitle.text = lesson.name
        var students = group.getStudents()
        studentsTableView.delegate = self
        studentsTableView.dataSource=self
                for student in students{
            
            self.studentID.insert(student.id, at: i)
            self.studentName.insert(student.firstname + " " + student.lastname, at: i)
               
          i = 1 + i
        }
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return studentName.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=studentsTableView.dequeueReusableCell(withIdentifier: "sigleLessonCell", for: indexPath) as! teacherSingleLessonTableViewCell
        
        cell.StdName.text = self.studentName[indexPath.row]

        
              // cell.StdName.text=
       
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backToLessons") {
            let lessons = segue.destination as! TeacherLessonsViewController;
            lessons.group = self.group
            
        }
        if (segue.identifier == "selectProgress") {
            let note = segue.destination as! TeacherNotesViewController;
            note.StudentID = self.studentID[selected]
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected single lesson cell number: \(indexPath.row)!")
        
        selected=indexPath.row
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
