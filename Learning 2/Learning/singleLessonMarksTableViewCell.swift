//
//  singleLessonMarksTableViewCell.swift
//  Learning
//
//  Created by sara alhasan on 3/13/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class singleLessonMarksTableViewCell: UITableViewCell {

    @IBOutlet weak var hwimage: UIImage!
//    @IBOutlet weak var hwimage: UIImage!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var equation: UILabel!
    @IBOutlet weak var mark: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
