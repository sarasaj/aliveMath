//
//  StudentProfileViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var myHomeWorks: UIButton!
    @IBOutlet weak var signOut: UIButton!
    
//    var studID = ""
    var student = Student()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        ID.text = studID

//        student.id = studID
        
        student.get_student()
        
        name.text = student.firstname + " "+student.lastname
        ID.text = student.id
        email.text = student.email
        image.image = UIImage(data:(student.image as NSData) as Data,scale:1.0)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signoutfromsystem(_ sender: Any) {
        
        student = Student()
        print("Student Sign Out")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "studsitting") {
            let stu = segue.destination as! StudentSettingsViewController;
            stu.student =  self.student
        }
        
        if (segue.identifier == "goToSHW") {
            let stu = segue.destination as! StudentLessonsViewController;
            stu.student =  self.student
        }

    }

    @IBAction func openPhotoLibrary(_ sender: AnyObject) {
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
            print("ORIGINAL")
            
            self.image.image = image
            student.updateStdImage(newProfileImage: self.image.image!)
        }
        else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            print("EDITED")
            self.image.image = image
            
            student.updateStdImage(newProfileImage: self.image.image!)
            
        }
        else{
            print("ELSE")
            print("Something went wrong")
        }
        
        student.update_student()
        self.dismiss(animated: true, completion: nil)
    }



}
