//
//  DrawView.swift
//  Checkbox
//
//  Created by Dima Paliychuk on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

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
        
        commandInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commandInit()
    }
    
    func commandInit() {
        
        animation.duration = 2
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeEnd = 1
        
        print("draw command init")
    }
    
    func startAnimation() {
        self.isHidden = false
        shapeLayer.removeAllAnimations()
        shapeLayer.add(animation, forKey: "animate")
    }
    
    func reversAnimation(duration: CFTimeInterval) {
        self.isHidden = false
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.isHidden = true
        })
        let revAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        revAnimation.fromValue = shapeLayer.presentation()?.strokeEnd
        revAnimation.toValue = 0.0
        revAnimation.timingFunction = animation.timingFunction
        revAnimation.duration = duration
        
        shapeLayer.removeAllAnimations()
        shapeLayer.add(revAnimation, forKey: "animate")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            CATransaction.commit()
        }
        
    }
}
