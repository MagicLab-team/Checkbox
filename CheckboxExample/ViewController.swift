//
//  ViewController.swift
//  CheckboxExample
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import Checkbox


class ViewController: UIViewController {

    @IBOutlet weak var bigCheckbox: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkbox = CheckBox(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100),
            borderType: .circle(animation: AnimationType.fade),
            checkType: .circle(circleAnimation: CircleAnimationType.fade)
        )

        view.addSubview(checkbox)
        checkbox.selectedBorderColor = UIColor.yellow
        
        checkbox.unselectedBorderColor = UIColor.lightGray
        checkbox.unselectedCheckColor = UIColor.clear
        checkbox.selectedBorderColor = UIColor.blue
        checkbox.selectedCheckColor = UIColor.blue
        checkbox.animationDuration = 0.5
        checkbox.lineWidth = 5
        
        checkbox.check()
        
        bigCheckbox.isHidden = true
        bigCheckbox.unselectedBorderColor = UIColor.lightGray
        bigCheckbox.unselectedCheckColor = UIColor.clear
        bigCheckbox.selectedBorderColor = UIColor.blue
        bigCheckbox.selectedCheckColor = UIColor.blue
        bigCheckbox.animationDuration = 0.5
        bigCheckbox.lineWidth = 5
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

