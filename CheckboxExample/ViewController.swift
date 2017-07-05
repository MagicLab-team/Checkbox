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
        
        let checkbox = CheckBox(frame: CGRect(x: 100, y: 100, width: 100, height: 150))
        view.addSubview(checkbox)
        checkbox.selectedBorderColor = UIColor.yellow
        
        
        
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

