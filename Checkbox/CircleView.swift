//
//  CircleView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: DrawView {
    
    
    override func commonInit() {
        super.commonInit()
        
        let diameter = frame.size.width < frame.size.height ? frame.size.width : frame.size.height
        path = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0
            ),
            radius: diameter / 2,
            startAngle: 0.0,
            endAngle: CGFloat(.pi * 2.0),
            clockwise: true
        )
        
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        shapeLayer.backgroundColor = UIColor.red.cgColor
        print("circle commonInit")
    }
    
}

