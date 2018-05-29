//
//  StudentSettingsViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit
import RealmSwift

class StudentSettingsViewController: UIViewController {
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var saveChanges: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var student = Student()
    
    let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*");
    let Englishpredicate = NSPredicate(format: "SELF MATCHES %@", "@[A-Za-z]+");

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        firstname.text = student.firstname
        lastname.text = student.lastname
        email.text = student.email
        password.text = student.password
        repeatPassword.text = student.password
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
        
        errorLabel.isHidden=false
        errorLabel.text=""
        
        if(firstname.text?.isEmpty ?? true || lastname.text?.isEmpty ?? true || email.text?.isEmpty ?? true || password.text?.isEmpty ?? true || repeatPassword.text?.isEmpty ?? true ){
            errorLabel.text = "قم بإدخال البيانات من فضلك "
        }
        else if (!(password.text == repeatPassword.text)){
            errorLabel.text = "أدخل كلمتي مرور متطابقة"
            repeatPassword.isHighlighted=true
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
            student.firstname = firstname.text!
            student.lastname = lastname.text!
            student.email = email.text!
            student.password = password.text!
            student.password = repeatPassword.text!
            
            let updated = student.update_student()
            
            if(updated){
                
                firstname.text = student.firstname
                lastname.text = student.lastname
                email.text = student.email
                password.text = student.password
                repeatPassword.text = student.password
                errorLabel.text = "تم حفظ التغييرات"
            }
            else{
                errorLabel.text = "لم يتم حفظ التغييرات"
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if (segue.identifier == "studentProfileBack") {
            let profile = segue.destination as! StudentProfileViewController;
            profile.student = self.student
        }
    
    }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

