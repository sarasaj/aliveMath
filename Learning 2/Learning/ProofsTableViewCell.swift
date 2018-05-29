//
//  ProofsTableViewCell.swift
//  AliveMath
//
//  Created by sara alhasan on 3/12/17.
//  Copyright © 2017 sara alhasan. All rights reserved.
//

import UIKit

class ProofsTableViewCell: UITableViewCell {

    @IBOutlet weak var VideoName: UILabel!
    
    @IBOutlet weak var VideoDescrption: UILabel!
    

    @IBOutlet weak var VideoPath: UILabel!
    
    @IBOutlet weak var VideoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
