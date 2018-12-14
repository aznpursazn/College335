//
//  CityTableViewCell.swift
//  Lab6
//
//  Created by Kathy Nguyen on 10/22/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
