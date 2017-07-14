//
//  StarView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/14/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: DrawView {
    
    override func commonInit() {
        super.commonInit()
        
        let onePercentHeight: CGFloat = frame.height/100
        let onePercentWidth: CGFloat = frame.width/100
        
        path.move(to: CGPoint(x: onePercentWidth*50, y: 0))
        path.addLine(to: CGPoint(x: onePercentWidth*65, y: onePercentHeight*35))
        path.addLine(to: CGPoint(x: onePercentWidth*100, y: onePercentHeight*35))
        path.addLine(to: CGPoint(x: onePercentWidth*70, y: onePercentHeight*65))
        path.addLine(to: CGPoint(x: onePercentWidth*85, y: onePercentHeight*100))
        path.addLine(to: CGPoint(x: onePercentWidth*50, y: onePercentHeight*75))
        path.addLine(to: CGPoint(x: onePercentWidth*15, y: onePercentHeight*100))
        path.addLine(to: CGPoint(x: onePercentWidth*30, y: onePercentHeight*65))
        path.addLine(to: CGPoint(x: 0, y: onePercentHeight*35))
        path.addLine(to: CGPoint(x: onePercentWidth*35, y: onePercentHeight*35))
        path.addLine(to: CGPoint(x: onePercentWidth*50, y: 0))
        
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
}
