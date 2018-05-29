//
//  ProofsViewController.swift
//  AliveMath
//
//  Created by sara alhasan on 3/12/17.
//  Copyright © 2017 sara alhasan. All rights reserved.
//

import UIKit
import RealmSwift

class proofsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var proofsTableview: UITableView!
    
    var proofid : [String] = []
    var videonames : [String] = []
    var selectedCell: Int = 0;
    public var realm: Realm? = SetUpRealm.realm
    
    override func viewDidLoad() {
        
        
        
        
//        SetUpRealm.setupRealm(){ (realm) -> Void in
//            
//        print("RAWAN & SARA are working")
//        let s1 = Student()
//        s1.realm = realm
//            
//        s1.firstname = "روان"
//        s1.lastname = "عبد الله"
//        s1.email = "rawan.abdullah.bs@Hotmail.com"
//        s1.id = "43201096"
//        s1.password = "123"
//        s1.set_student()
//
//        let s2 = Student()
//        s2.realm = realm
//        s2.firstname = "سارا"
//        s2.lastname = "سجاد"
//        s2.email = "rawan.abdullah.bs@Hotmail.com"
//        s2.id = "43304302"
//        s2.password = "123"
//        s2.set_student()
//        
//        let s3 = Student()
//        s3.realm = realm
//        s3.firstname = "أميمة"
//        s3.lastname = "عابد"
//        s3.email = "rawan.abdullah.bs@Hotmail.com"
//        s3.id = "43210"
//        s3.password = "123"
//        s3.set_student()
//        
//        //self.setupRealm()
//
////        let s1 = Student()
////        s1.firstname = "RAWAN"
////        s1.lastname = "Abdullah"
////        s1.email = "RAWAN@Hotmail.com"
////        s1.id = "43201096"
////        s1.password = "123"
////        s1.set_student()
////        
////        
//        let t1 = Teacher()
//        t1.realm = realm
//        t1.firstname = "خلود"
//        t1.lastname = "عبد الله"
//        t1.email = "rawan.abdullah.bs@Hotmail.com"
//        t1.id = "44"
//        t1.password = "44"
//        t1.major = "رياضيات"
//        t1.set_teacher()
////        t1.getGroups()
////
//        var p1 = Proof()
//        p1.realm = realm
//        p1.id = "1"
//        p1.title = "Where Does The Volume of a Cylinder Formula Come From?"
//        p1.category = "Volume"
//        p1.imagePath = "VPath1"
//        p1.videoPath = "<iframe width=\"375\" height=\"203\" src=\"https://www.youtube.com/embed/s0IOtwKMaEQ\" frameborder=\"0\" allowfullscreen></iframe>"
//        let added = p1.add()
////        print(added)
//
//        
//        let p2 = Proof()
//        p2.realm = realm
//        p2.id = "2"
//        p2.title = "الدائرة"
//        p2.category = "مساحات"
//        p2.imagePath = "VPath2"
//        p2.videoPath = "ImPath2"
//        let added2 = p2.add()
////        print(added2)
//
//        let p3 = Proof()
//        p3.realm = realm
//        p3.id = "3"
//        p3.title = "الدالة المثلثية : جا"
//        p3.category = "الدوال المثلثية"
//        p3.imagePath = "VPath3"
//        p3.videoPath = "ImPath3"
//        let added3 = p3.add()
////        print(added3)
//        
//        
////        let category = try! Realm().objects(ProofObject.self).sorted(byProperty: "category")
////        let count = try! Realm().objects(ProofObject.self).sorted(byProperty: "category").count
////        
////        let filteredcategory = try! Realm().objects(ProofObject.self).sorted(byProperty: "category").filter("category")
////        
////        let filteredcategorycount = try! Realm().objects(ProofObject.self).sorted(byProperty: "category").filter("category").count
//        
////        print(category)
////        print("=====")
////        print(count)
////        
////        print("(=====)")
////        print(filteredcategory)
////        print("=====")
////        print(filteredcategorycount)
//        var group2 = Group()
//        group2.realm = realm
//        group2.groubnumber = "66"
//        group2.setgroup()
//        group2.addTeacherToGroup(t1: t1)
//        group2.addStudenToGroup(s1: s1)
//        group2.addStudenToGroup(s1: s2)
//        
//        var group = Group()
//        group.realm = realm
//        group.groubnumber = "45"
//        group.setgroup()
//        group.addTeacherToGroup(t1: t1)
//        group.addStudenToGroup(s1: s3)
//
//        var course = Course()
//        course.realm = realm
//        course.id = "001"
//        course.bookTitle = "رياضيات"
//        course.category = "رياضيات"
//        course.name = "رياضيات ٥"
//        course.set_course()
//        group.addCourseToGroup(c1: course)
////        course.get_course()
//        
//        var lesson = Lesson()
//        lesson.realm = realm
//        lesson.id = "203"
//        lesson.name = "المتطابقات المثلثية"
//        lesson.number = 1
//        lesson.set_lesson()
////        lesson.get_lesson()
//        
//        course.addLesson(L: lesson)
////        let equation = Equation()
////        equation.id = "E01"
//        let equation1 = Equation()
//        equation1.realm = realm
//        equation1.id = "E01"
//        equation1.equation = "sin 0"
//        equation1.add()
//        
//        
//        let equation2 = Equation()
//        equation2.realm = realm
//        equation2.id = "E02"
//        equation2.equation = "tan 0"
//        equation2.add()
//        
//        let equation3 = Equation()
//        equation3.realm = realm
//        equation3.id = "E03"
//        equation3.equation = "E = (I cos 0) ÷ (R^2)"
//        equation3.add()
////        equation.equation = "y = x + sin(0.5)"
////        print(equation3.add())
//        
////
//        let realife = RealLife()
//        realife.realm = realm
//        realife.id = "01"
//        print(realife.add())
//        let realife2 = RealLife()
//        realife2.id = "02"
//        realife2.add()
//        
//        
//        let E = Exercise()
//        E.realm = realm
//        E.id = "01"
//        E.number = 3
//        E.page = "33"
//        E.question = "(sin 0 * csc 0) ÷ cot 0 بسط العبارة : "
//        E.equation = equation2
//        E.real_life = realife
//        E.setExercise()
//        let E2 = Exercise()
//        E2.realm = realm
//        E2.id = "02"
//        E2.number = 4
//        E2.page = "33"
//        E2.question = "حل المعدلة sec 0 = 1 ÷ ER^2 بالنسبة لـ E"
//        E2.equation = equation3
//        E2.real_life = realife2
//        E2.setExercise()
//        let E3 = Exercise()
//        E3.realm = realm
//        E3.id = "03"
//        E3.number = 4
//        E3.page = "33"
//        E3.question = "أثبت أن المعادلة تمثل متطابقة : cos(90 - 0) = sin 0"
//        E3.equation = equation1
//        E3.real_life = realife2
//        E3.setExercise()
//
//        var hw = Homework()
//        hw.realm = realm
//        hw.id = 1
//        hw.lesson = lesson
//        
//        hw.addHomeworke()
//        hw.addExercise(E: E)
//        
//        var hw2 = Homework()
//        hw2.realm = realm
//        hw2.id = 2
//        hw2.lesson = lesson
////
//        hw2.addHomeworke()
//        hw2.addExercise(E: E2)
//        hw2.addExercise(E: E3)
//
//        var hw3 = Homework()
//        hw3.realm = realm
////        hw3.id = 3
//        hw3.lesson = lesson
//        hw3.group = group
////        hw3.addHomeworkByTeacher(homework: hw2)
//
////        print(hw3.getAllHW())
//
//        var hw4 = Homework()
//        hw4.realm = realm
//        hw4.lesson = lesson
//        hw4.group = group2
////        hw4.addHomeworkByTeacher(homework: hw)
//        
////        var progrss = Progress()
////        var SPs = progrss.getStudentProgresses(SID: "43201096")
////        var solution = Solution()
////        
////        for p in SPs!{
////            print(p.course.id)
////            print(p.homework.id)
////            print(p.compoundKey)
////            
////        }
////        print("====================")
////        print("====================")
////        print("====================")
////        let SPSs = solution.viewSolutions(progressID: "432010960014")
////        
////        for s in SPSs! {
////            print(s.exercise.equation.equation)
////            print(s.mark)
////            print(s.solution)
////        }
////        
////        progrss.course = course
////        progrss.student = s1
////        progrss.homework = hw3
////        progrss.uploadSolution(exercise: E3, solution: "x+4")
////        progrss.addNote(Note: "GOOD JOB")
////
////        print(hw.id)
////        print(hw2.id)
////        print(hw3.id)
//        }
        super.viewDidLoad()
        proofsTableview.delegate = self
        proofsTableview.dataSource=self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        let count = try! realm?.objects(ProofObject.self).sorted(byKeyPath: "category").count
//
//        print(category)
//        print("=====")
//        print(count)
        return count!
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=proofsTableview.dequeueReusableCell(withIdentifier: "proofsCell", for: indexPath) as! ProofsTableViewCell
        
        print("===========================in proofs ===========================")
        realm = SetUpRealm.realm
        let proofs = realm?.objects(ProofObject.self).sorted(byProperty: "category")
        
        
        var videopath : [String] = [""]
        var imagepath : [String] = [""]
        
        
        var i:Int = 0
          for proof in proofs!{
            print("in loop")
            print("         proof:",proof)
            videonames.insert( proof.title, at: i)
            videopath.insert( proof.videoPath, at: i)
            imagepath.insert( proof.imagePath, at: i)
            proofid.insert( proof.id, at: i)
          i += 1
        }
        cell.VideoName.text=videonames[indexPath.row]
        cell.VideoPath.text = videopath[indexPath.row]
        //cell.VideoImage.text=imagepath[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        selectedCell=indexPath.row
        self.performSegue(withIdentifier: "youtubeVid", sender: indexPath);
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backToCam") {
            let cam = segue.destination as! ViewController;
            
           
            
        }
        else if (segue.identifier == "youtubeVid") {
            let pro = segue.destination as! VideoViewController;
            var proofobj = Proof()
            proofobj.id = proofid[selectedCell]
            print("proofid[selectedCell]", proofid[selectedCell])
            proofobj.load()
            print("obj info :",proofobj.title)
            
            pro.YTvideo = proofobj
            
            print ("selectedCell", selectedCell)
            print ("selectedCell 2", videonames[selectedCell])
            pro.vidtitle = videonames[selectedCell]
            
        }
        
    }

}
