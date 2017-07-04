//
//  TickView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

@IBDesignable
class TickView: DrawView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        path.move(to: CGPoint(x: 0, y: frame.height/2))
        path.addLine(to: CGPoint(x: frame.width/2, y: frame.height))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func commandInit() {
        super.commandInit()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.height/2))
        path.addLine(to: CGPoint(x: frame.width/2, y: frame.height))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        
        print("tick command init")
    }
}

