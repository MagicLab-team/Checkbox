//
//  DrawView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

//animation sytoke
//fade

@IBDesignable
class DrawView: UIView {
    
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    let shapeLayer = CAShapeLayer()
    var path = UIBezierPath() {
        didSet {
            shapeLayer.path = path.cgPath
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        animation.duration = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(
            name: kCAMediaTimingFunctionLinear
        )
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeEnd = 1
        
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
    }
    
    func startAnimation() {
        self.isHidden = false
        shapeLayer.removeAllAnimations()
        shapeLayer.add(animation, forKey: "animate")
    }
    
    func reverseAnimation(duration: CFTimeInterval) {
        let revAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        revAnimation.fromValue = shapeLayer.presentation()?.strokeEnd
        revAnimation.toValue = 0.0
        revAnimation.timingFunction = animation.timingFunction
        revAnimation.duration = duration
        revAnimation.isRemovedOnCompletion = false
        revAnimation.fillMode = kCAFillModeForwards
        
        shapeLayer.removeAllAnimations()
        shapeLayer.add(revAnimation, forKey: "animate")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + revAnimation.duration) {
            self.isHidden = true
        }
    }
}
