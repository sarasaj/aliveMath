//
//  TeacherProfileViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherProfileViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var email: UILabel!

    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var setting: UIButton!
    @IBOutlet weak var groups: UIButton!
    @IBOutlet weak var signOut: UIButton!
     var teacID = ""
     var teacher = Teacher()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teacID = teacher.id
        teacher = teacher.get_teacher(TID: teacID)
        name.text = teacher.firstname+" "+teacher.lastname
        ID.text = teacher.id
        email.text = teacher.email
        major.text = teacher.major
        image.image = UIImage(data:(teacher.image as NSData) as Data,scale:1.0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signout(_ sender: Any) {
        teacher = Teacher()
        print("=======")
        print(teacher.description)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "teacsitting") {
            let teac = segue.destination as! TeacherSettingViewController;
            print(self.teacher.description)
            teac.teacher =  self.teacher
        }
        if (segue.identifier == "goToTgroups") {
            let groups = segue.destination as! TeacherGroupsViewController;
            print("Im IN : teacher groups)")
            print(self.teacher.description)
            groups.teacher =  self.teacher
        }
        
    }
    
    @IBAction func openPhotolib(_ sender: AnyObject) {
        
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
            teacher.updateTeacherImage(newProfileImage: self.image.image!)
        }
        else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            print("EDITED")
            self.image.image = image
            teacher.updateTeacherImage(newProfileImage: self.image.image!)
        }
        else{
            print("ELSE")
            print("Something went wrong")
        }
        
        teacher.update_teacher()
        self.dismiss(animated: true, completion: nil)
    }

}
