//
//  StudnetLessonsTableViewCell.swift
//  Learning
//
//  Created by Rawan Abdullah on 3/21/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class StudentLessonsTableViewCell : UITableViewCell {
   

    @IBOutlet weak var homeworkID: UILabel!
    var progressID : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
