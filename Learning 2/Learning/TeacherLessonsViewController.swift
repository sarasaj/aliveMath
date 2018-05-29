//
//  TeacherLessonsViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit
import RealmSwift
class TeacherLessonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var lessonsTable: UITableView!
    var selected=0
    var lessonsNumber : [String] = [""]
    var lessonstitle : [String] = [""]
    var groupNo : [String] = [""]
    var hwID : [Int] = [0]
    var i : Int = 0
    let homeworks = try! SetUpRealm.realm?.objects(HomeworkObject.self)

    var group = Group()
    override func viewDidLoad() {
    
 
        
        for hw in homeworks!{
            if(hw.group != nil){
              lessonsNumber.insert(hw.lesson.id, at: i)
               lessonstitle.insert(hw.lesson.name, at: i)
                groupNo.insert(hw.group.groupnumber, at: i)
                hwID.insert(hw.id, at: i)
                i += 1
            }
            
        }

        
        super.viewDidLoad()
        lessonsTable.delegate = self
        lessonsTable.dataSource=self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.lessonsNumber.count;
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=lessonsTable.dequeueReusableCell(withIdentifier: "TchrlessonsCell", for: indexPath) as! TeacherLessonTableViewCell

        
        cell.lessonNo.text = lessonsNumber[indexPath.row]
        cell.lessonTitle.text = lessonstitle[indexPath.row]
        cell.groupNo.text = groupNo[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backToSingeGroup") {
            let singleGroup = segue.destination as! TeacherSingleGroupViewController;
            singleGroup.group = self.group
            
        }
        else if (segue.identifier == "gotoSingleLesson") {
            let singleLesson = segue.destination as! TeacherSingleLessonViewController;
            singleLesson.group = self.group
            singleLesson.lesson.id = (homeworks?[selected].lesson.id)!
            singleLesson.lesson.name = (homeworks?[selected].lesson.name)!
            singleLesson.lesson.number = (homeworks?[selected].lesson.number)!
            singleLesson.hwID = hwID[selected]
//            print("++++++")
//            print(homeworks[selected].id)
//            print("++++++")
//            print(hwID[selected])
        }
        else{
            
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected lesson cell number: \(indexPath.row)!")
        
        selected=indexPath.row
    }


}
