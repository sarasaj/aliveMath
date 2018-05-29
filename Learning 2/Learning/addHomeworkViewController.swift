//
//  addHomeworkViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/17/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class addHomeworkViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    //UI elements
    @IBOutlet weak var hwPicker: UIPickerView!
    @IBOutlet weak var dealline: UIDatePicker!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var HwAdded: UILabel!
    
    //var
    var date : String = ""
    var rowNo : Int = 0
    //hw picker arrays
    var pickerData: [String] = []
    var AllHw : Array<Homework> = []
    
    //objects
    var group = Group()
    var h = Homework()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Group : " + group.groubnumber)
        HwAdded.text = ""
        self.hwPicker.delegate = self
        self.hwPicker.dataSource = self
        print("ADD HW VIEW CONTROLLRER")
        self.AllHw = h.getAllHW()
        for hw in self.AllHw {
            pickerData.append("الواجب" + String(hw.id))
        }
        print("ADD HW VIEW CONTROLLRER")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    @IBAction func datePicker(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: dealline.date)
        self.date = strDate
//        var d : Date = NSData.init(contentsOfFile: strDate)
        
       // let date = dateFormatter.date(from: String)
//        return date
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        rowNo = row
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    @IBAction func addNewHw(_ sender: Any) {
        
        //group.id - date var for deadline- value from hw picker from function above 
        h.deadLine = dealline.date as Date?
        h.group = self.group
        if( h.addHomeworkByTeacher(homework: AllHw[rowNo]) ){

           print("IM HERE")
           let students =  h.group.getStudents()
            for student in students{
                print("====")
                print(h.id)
                print("====")
                h = h.getHomework(HWID: h.id)
                var progress = Progress()

//                progress.getProgress(ProgressID: <#T##String#>)
                progress.course = (h.lesson?.course)!

                progress.homework = h
                progress.student = student
                progress.uploadSolution(exercises: h.exercieses!, solution: nil)
            }
            addBtn.isEnabled = false
            addBtn.backgroundColor =  UIColor.gray
            HwAdded.text = "تمت إضافة الواجب بنجاح"
        }
        else {
            HwAdded.text = "لم يتم إضافة الواجب"
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backtoSinglegroup") {
            let singlegroup = segue.destination as! TeacherSingleGroupViewController;
            singlegroup.group = self.group
            
            
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

}
