//
//  HeartView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/14/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

@IBDesignable
class HeartView: DrawView {
    
    override func commonInit() {
        super.commonInit()
        
        path = UIBezierPath(heartIn: self.bounds)
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
}
