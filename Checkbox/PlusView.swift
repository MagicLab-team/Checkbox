//
//  PlusView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/14/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

@IBDesignable
class PlusView: DrawView {
    
    override func commonInit() {
        super.commonInit()
        
//        path.move(to: CGPoint(x: frame.width/2, y: 0))
//        path.addLine(to: CGPoint(x: frame.width/2, y: frame.height))
//        path.move(to: CGPoint(x: 0, y: frame.height/2))
//        path.addLine(to: CGPoint(x: frame.width, y: frame.height/2))
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        
        path.move(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
}
