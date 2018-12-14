//
//  DetailedViewController.swift
//  Lab5
//
//  Created by Kathy Nguyen on 10/19/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import CoreData

class DetailedViewController: UIViewController {
    
    var city:String?
    var image:NSData?
    var info:String?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageBox: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = city
        guard let cIm = image else {
            print("Error in loading image")
            return
        }
        imageBox.image = UIImage(data: cIm as Data)
        infoLabel.text = info

        // Do any additional setup after loading the view.
    }

}
