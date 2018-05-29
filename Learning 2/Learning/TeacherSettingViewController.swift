//
//  TeacherSettingViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherSettingViewController: UIViewController {
    
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var saveChanges: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var major: UITextField!
    
    var teacher = Teacher()
    
    let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*");
    let Englishpredicate = NSPredicate(format: "SELF MATCHES %@", "@[A-Za-z]+");

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        firstname.text = teacher.firstname
        lastname.text = teacher.lastname
        email.text = teacher.email
        major.text = teacher.major
        password.text = teacher.password
        repeatPassword.text = teacher.password
        errorLabel.isHidden=true
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func update(_ sender: Any) {
        
        if(firstname.text?.isEmpty ?? true || lastname.text?.isEmpty ?? true || email.text?.isEmpty ?? true || password.text?.isEmpty ?? true || repeatPassword.text?.isEmpty ?? true ){
            errorLabel.isHidden=false
            errorLabel.text = "لا تترك اي خانات فارغة من فضلك"
        }
        else if (!(password.text == repeatPassword.text)){
            errorLabel.isHidden=false
            errorLabel.text = "أدخل كلمتي مرور متطابقة"
        }
            
        else if ( !predicate.evaluate(with: lastname.text) && !Englishpredicate.evaluate(with: lastname.text)
            ){
            errorLabel.text = "أدخل حروف عربية أو انجليزية فقط"
            lastname.isHighlighted=true
        }
        else if (!predicate.evaluate(with: firstname.text) && !Englishpredicate.evaluate(with: firstname.text)){
            
            errorLabel.text = "أدخل حروف عربية أو انجليزية فقط"
            firstname.isHighlighted=true
        }

        else{
            
            teacher.firstname = firstname.text!
            teacher.lastname = lastname.text!
            teacher.email = email.text!
            teacher.password = password.text!
            teacher.password = repeatPassword.text!
            
            let updated = teacher.update_teacher()
            
            if(updated){
                
                firstname.text = teacher.firstname
                lastname.text = teacher.lastname
                email.text = teacher.email
                password.text = teacher.password
                repeatPassword.text = teacher.password
                errorLabel.text = "تم حفظ التغييرات"
            }
            else{
                errorLabel.text = "لم يتم حفظ التغييرات"
            }
        }
  
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "teacherProfileBack") {
            let profile = segue.destination as! TeacherProfileViewController;
            profile.teacher = self.teacher
        }
        
    }
    
}
