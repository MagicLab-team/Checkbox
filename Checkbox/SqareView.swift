//
//  SqareView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/10/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class SqareView: DrawView {
    
    private var cornerRadii: Int
    
    init(frame: CGRect, animationType: AnimationType, cornerRadii: Int) {
        self.cornerRadii = cornerRadii
        super.init(frame: frame, animationType: animationType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.cornerRadii = 0
        super.init(coder: aDecoder)
    }

    override func commonInit() {
        super.commonInit()
        
        path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: cornerRadii, height: 0)
        )
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
        print("circle commonInit")
    }
    
}
