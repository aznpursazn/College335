//
//  InfoTableViewCell.swift
//  Lab7
//
//  Created by Kathy Nguyen on 10/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
   
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
