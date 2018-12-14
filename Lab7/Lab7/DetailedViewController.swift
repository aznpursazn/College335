//
//  DetailedViewController.swift
//  Lab7
//
//  Created by Kathy Nguyen on 10/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var d:NSString?
    var dp:NSNumber?
    var ln:NSNumber?
    var lt:NSNumber?
    var mg:NSNumber?
    var sc:NSString?
    var eq:NSString?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var magLabel: UILabel!
    @IBOutlet weak var srcLabel: UILabel!
    @IBOutlet weak var eqLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = d! as String
        depthLabel.text = dp?.stringValue
        longLabel.text = ln?.stringValue
        latLabel.text = lt?.stringValue
        magLabel.text = mg?.stringValue
        srcLabel.text = sc! as String
        eqLabel.text = eq! as String
        // Do any additional setup after loading the view.
    }

}
