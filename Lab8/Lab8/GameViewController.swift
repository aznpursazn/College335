//
//  GameViewController.swift
//  Lab8
//
//  Created by Kathy Nguyen on 11/21/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var timer : Timer?
    var counter  = 0
    
    @IBOutlet weak var topApple: UIImageView!
    @IBOutlet weak var leftApple: UIImageView!
    @IBOutlet weak var bottomApple: UIImageView!
    @IBOutlet weak var rightApple: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var monkey: UIImageView!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var up: UIButton!
    @IBOutlet weak var down: UIButton!
    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var right: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.count), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func count()
    {
        counter = counter + 1
        if counter <= 10 {
            timeLabel.text = String(counter)
            if self.leftApple.isHidden, self.rightApple.isHidden, self.topApple.isHidden, self.bottomApple.isHidden  {
                timer?.invalidate()
                up.isEnabled = false
                down.isEnabled = false
                right.isEnabled = false
                left.isEnabled = false
                displayLabel.text = "You won! :D Congratulations!"
                return
            }
        } else {
            up.isEnabled = false
            down.isEnabled = false
            right.isEnabled = false
            left.isEnabled = false
            displayLabel.text = "You lost! :C Try again!"
        }
    }
    
    @IBAction func upAction(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.y -= 10
        self.monkey.frame = frame
        
        self.checkApple()
    }
    @IBAction func rightAction(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.x += 10
        self.monkey.frame = frame
        
        self.checkApple()
    }
    @IBAction func downAction(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.y += 10
        self.monkey.frame = frame
        
        self.checkApple()
    }
    @IBAction func leftAction(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.x -= 10
        self.monkey.frame = frame
        
        self.checkApple()
    }
    
    func viewIntersectsView(_ first_View: UIView, second_View:UIView) -> Bool
    {
        return first_View.frame.intersects(second_View.frame)
    }
    
    func checkApple() {
        if (viewIntersectsView(monkey, second_View: topApple))
        {
            self.topApple.isHidden = true
        }
        if (viewIntersectsView(monkey, second_View: bottomApple))
        {
            self.bottomApple.isHidden = true
        }
        if(viewIntersectsView(monkey, second_View: leftApple))
        {
            self.leftApple.isHidden = true
        }
        if(viewIntersectsView(monkey, second_View: rightApple))
        {
            self.rightApple.isHidden = true
        }
    }
    
}
