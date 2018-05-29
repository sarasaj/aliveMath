//
//  Profile.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/10/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//
import UIKit
import Foundation
import RealmSwift

class Profile: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var UserPasswordTextField: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var SignInButton: UIButton!
    


//    @IBOutlet weak var inputTextView: UITextView!
//    @IBOutlet weak var inputTextField: UITextField!
    
    var student : Student = Student()
    var teacher : Teacher = Teacher()
   
    var noOfAttempts : Int = 0
    
    var realm : Realm? = SetUpRealm.realm
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        ErrorLabel.isHidden=true
        noOfAttempts=0
        
//        self.inputTextField.delegate = self
//        self.view.endEditing(true)
        
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
    
//     func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        self.inputTextView.resignFirstResponder()
//    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    @IBAction func onClick(_ sender: Any) {
        ErrorLabel.isHidden=false
        ErrorLabel.text=""
        
        if(UsernameTextField.text?.isEmpty ?? true){
            
            ErrorLabel.text = "قم بإدخال اسم المستخدم من فضلك"
            UsernameTextField.isHighlighted=true
        }
        else if (UserPasswordTextField.text?.isEmpty ?? true) {
            ErrorLabel.text = "قم بإدخال كلمة المرور"
            UserPasswordTextField.isHighlighted=true
        }
        else{
            var num:Int = 0
            num = check(id: UsernameTextField.text!, password:UserPasswordTextField.text! )
            if (num == -1){
                ErrorLabel.text = "البيانات غير صحيحة"
                noOfAttempts += 1
                if(noOfAttempts > 3){
                    ErrorLabel.text = "لقد قمت بثلاث محاولات غير صحيحة"
                }
            }
            if(num == 0){
                self.performSegue(withIdentifier: "teachpro", sender: self)
            }
            if(num == 1){
                self.performSegue(withIdentifier: "stupro", sender: self)
            }
            else{
                //            print("ERROR")
                
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "stupro") {
            let stu = segue.destination as! StudentProfileViewController;
            let student = Student()
            student.id = UsernameTextField.text!
            stu.student = student
            
        }
        
        if(segue.identifier == "teachpro"){
            let tea = segue.destination as! TeacherProfileViewController;
            let teacher = Teacher()
            teacher.id = UsernameTextField.text!
            tea.teacher = teacher
            
        }

    }
    
    
    
    func check(id : String, password : String) -> Int{
        
        let user =  realm?.object(ofType: ProfileObject.self, forPrimaryKey: id)
        
        if(user != nil){
            if(user?.password == password){
                return signIn(id: id)
            }
            else{
                return -1
            }
            
        }
        else{
            return -1
            //            print("User NOT Found")
        }
        
    }
    func signIn(id : String) -> Int{
        
        let student =  realm?.object(ofType: StudentObject.self, forPrimaryKey: id)
        
        if(student != nil){
            return 1
        }
        else{
            let teacher =  realm?.object(ofType: TeacherObject.self, forPrimaryKey: id)
            
            if(teacher != nil){
                return 0
            }
            else{
                return -1
            }
        }
        
    }
    
}
