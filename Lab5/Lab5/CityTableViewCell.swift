//
//  CityTableViewCell.swift
//  Lab5
//
//  Created by Kathy Nguyen on 10/20/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var imageBox: UIImageView? {
        didSet {
            imageBox?.layer.cornerRadius = (imageBox?.bounds.width)! / 2
            imageBox?.clipsToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
