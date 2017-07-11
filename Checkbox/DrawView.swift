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
    
    let animation: CABasicAnimation
    private let animationType: AnimationType
    
    let shapeLayer = CAShapeLayer()
    var path = UIBezierPath() {
        didSet {
            shapeLayer.path = path.cgPath
        }
    }
    
    init(frame: CGRect, animationType: AnimationType) {
        
        self.animationType = animationType
        
        switch animationType {
        case .stroke:
            self.animation = CABasicAnimation(keyPath: "strokeEnd")
        case .fade:
            self.animation = CABasicAnimation(keyPath: "opacity")
        case .size:
            self.animation = CABasicAnimation()
        }
        
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.animation = CABasicAnimation(keyPath: "strokeEnd")
        self.animationType = .stroke
        
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
        
        switch animationType {
        case .size:
            let third: CFTimeInterval = animation.duration/3
            UIView.animate(withDuration: third, animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: {(finished) in
                UIView.animate(withDuration: third, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }, completion: {(finished) in
                    UIView.animate(withDuration: third, animations: {
                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    })
                })
            })
        default:
            shapeLayer.removeAllAnimations()
            shapeLayer.add(animation, forKey: "animate")
        }
    }
    
    func reverseAnimation(duration: CFTimeInterval) {
        var key = ""
        switch animationType {
        case .stroke:
            key = "strokeEnd"
        case.fade:
            key = "opacity"
        case .size:
            self.isHidden = true
            return
        }
        
        let revAnimation = CABasicAnimation(keyPath: key)
        
        revAnimation.fromValue = shapeLayer.presentation()?.strokeEnd
        revAnimation.toValue = 0.0
        revAnimation.timingFunction = animation.timingFunction
        revAnimation.duration = duration
        revAnimation.isRemovedOnCompletion = false
        revAnimation.fillMode = kCAFillModeForwards
        
        shapeLayer.removeAllAnimations()
        shapeLayer.add(revAnimation, forKey: "animate")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.isHidden = true
        }
        
    }
    
}
