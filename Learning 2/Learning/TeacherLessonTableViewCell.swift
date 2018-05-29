//
//  TeacherLessonTableViewCell.swift
//  Learning
//
//  Created by sara alhasan on 3/17/17.
//  Copyright © 2017 Rawan Abdullah. All rights reserved.
//

import UIKit

class TeacherLessonTableViewCell: UITableViewCell {

    @IBOutlet weak var lessonNo: UILabel!
    @IBOutlet weak var lessonTitle: UILabel!
    
    @IBOutlet weak var groupNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
