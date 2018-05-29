//
//  StudentSubmitHWViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class StudentSubmitHWViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var changes: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var addAnswer: UIButton!
    @IBOutlet weak var equation: UITextField!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var mark: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var upladImage: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    let date = Date()
    
    var student = Student()
    var solution = Solution()
    var progress = Progress()
    var studentProgs : Int = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        addImage.image = UIImage()

        question.text = solution.question
        equation.text = solution.solution
        print(progress.note)
        
        notes.text = progress.note
        changes.isHidden = false
//        let deadline = progress.homework.deadLine
        changes.text = ""
        addImage.image = UIImage(data:(solution.image as NSData) as Data,scale:1.0)
        
//        addImage = solution.exercise.image
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

      
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func editHw(_ sender: Any) {
        progress = progress.getProgress(ProgressID: progress.compoundKey)
        
        let date = Date()
        
        print("date :",date)
        print("deadline :",progress.homework.deadLine!)
        
        switch date.compare(progress.homework.deadLine!){
        case .orderedAscending     :
            //Date A is earlier than date B
        equation.isEnabled = true
        equation.isUserInteractionEnabled = true
        upladImage.isEnabled = true
        upladImage.backgroundColor = UIColor.red
        submit.isEnabled = true
        submit.backgroundColor = UIColor.red
        
        break
        case .orderedDescending    :   print("Date A is later than date B")
        changes.text = "انتهى موعد التسليم"
            break
        case .orderedSame          :   print("The two dates are the same")
        changes.text = "انتهى موعد التسليم"
            break
        }

    }
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
      
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
        
            let imagePicker = UIImagePickerController()
          
            imagePicker.delegate = self
          
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
          
            imagePicker.allowsEditing = true
          
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("INSIDE CONTROLLER")
        picker.delegate = self
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.addImage.image = image
        }
        else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.addImage.image = image
        }
        else{
            print("ELSE")
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "backToSLess") {
            let submit = segue.destination as! StudentSingleLessonViewController;
           var  progressArray = progress.getStudentProgresses(SID: self.student.id)!
            submit.progressID = progressArray[studentProgs].compoundKey
            submit.progress = progressArray[studentProgs]
            submit.progress = self.progress
            submit.student = self.student
        }
        
    }

    @IBAction func submitSolution(_ sender: Any) {


        let imageData: NSData = UIImagePNGRepresentation(addImage.image!)! as NSData
        solution.insertSolutionByStudent(insertedSolution: equation.text!, progressID: progress.compoundKey, exerciseID: solution.exercise.id, URL:imageData)
        
        submit.backgroundColor = UIColor.blue
        changes.isHidden = false
        changes.text = "تم إضافة التغييرات بنجاح"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
