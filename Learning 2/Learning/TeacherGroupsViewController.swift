//
//  TeacherGroupsViewController.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherGroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var teacher = Teacher()
    @IBOutlet weak var groupsTable: UITableView!
    var groupsArray : [String]!
    var groupNo : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsTable.delegate = self
        groupsTable.dataSource=self
        
        groupsArray = teacher.getGroupsArray()
        
        print("GROUP ARRAY IN VC")
        print(groupsArray.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.groupsArray.count;
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("Inside cell")
        let cell=groupsTable.dequeueReusableCell(withIdentifier: "tchrCell", for: indexPath) as! TeacherGroupsTableViewCell
        
        
                cell.groupNumber.text = groupsArray[indexPath.row]
        print("the FT group : " + "\(cell.groupNumber.text )")
                return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "groupBack") {
            let teac = segue.destination as! TeacherProfileViewController;

            teac.teacher =  self.teacher

        }
        if (segue.identifier == "selectGroup") {
            let g = segue.destination as! TeacherSingleGroupViewController;
            
            let G = Group()
            
            G.groubnumber = groupsArray[groupNo]
            print("^^^^^^^")
            print(G.groubnumber)
            
            g.group = G.get_group(GID: G.groubnumber)
            
        }
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        groupNo = indexPath.row
    }
}

