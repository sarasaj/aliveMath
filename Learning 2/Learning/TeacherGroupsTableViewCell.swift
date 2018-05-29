//
//  TeacherGroupsTableViewCell.swift
//  Learning
//
//  Created by sara alhasan on 3/16/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherGroupsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var groupNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
