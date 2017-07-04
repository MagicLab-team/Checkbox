//
//  Checkbox.swift
//  Checkbox
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


@IBDesignable
public class CheckBox: UIView {
    
    private (set) var selectedCircleView: CircleView!
    private (set) var selectedCheckView: CheckView!
    
    private (set) var unselectedCircleView: CircleView!
    private (set) var unselectedCheckView: CheckView!
    
    private var unselectedViews: [DrawView]!
    private var selectedViews: [DrawView]!
    
    
    public var unselectedBorderColor: UIColor = UIColor.clear {
        didSet {
            unselectedCircleView.shapeLayer.strokeColor = unselectedBorderColor.cgColor
        }
    }
    public var selectedBorderColor: UIColor = UIColor.clear {
        didSet {
            selectedCircleView.shapeLayer.strokeColor = selectedBorderColor.cgColor
        }
    }
    public var unselectedCheckColor: UIColor = UIColor.clear {
        didSet {
            unselectedCheckView.shapeLayer.strokeColor = unselectedCheckColor.cgColor
        }
    }
    public var selectedCheckColor: UIColor = UIColor.red {
        didSet {
            selectedCheckView.shapeLayer.strokeColor = selectedCheckColor.cgColor
        }
    }
    public var borderAnimationDuration: TimeInterval = 0.3 {
        didSet {
            unselectedCircleView.animation.duration = borderAnimationDuration
            selectedCircleView.animation.duration = borderAnimationDuration
        }
    }
    public var checkAnimationDuration: TimeInterval = 0.3 {
        didSet {
            unselectedCheckView.animation.duration = checkAnimationDuration
            selectedCheckView.animation.duration = checkAnimationDuration
        }
    }
    public var animationDuration: TimeInterval = 0.3 {
        didSet {
            borderAnimationDuration = animationDuration
            checkAnimationDuration = animationDuration
        }
    }
    public var clickHandler: ((_ isChecked: Bool)->Void)?
    
    
    internal (set) public var isChecked: Bool = false {
        didSet {
            clickHandler?(isChecked)
        }
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    private func setup() {
        let circleFrame = CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: frame.height
        )
        selectedCircleView = CircleView(frame: circleFrame)
        
        let squareSize = frame.height <= frame.width ? frame.height : frame.width
        
        let tickViewWidth = squareSize / 2
        let tickViewHeight = squareSize / 2
        
        selectedCheckView = CheckView(
            frame: CGRect(
                x: frame.width / 2 - tickViewWidth / 2,
                y: frame.height / 2 - tickViewHeight / 2,
                width: tickViewWidth,
                height: tickViewHeight
            )
        )
        selectedCircleView.shapeLayer.strokeColor = selectedBorderColor.cgColor
        selectedCircleView.shapeLayer.lineWidth = 2
        
        selectedCheckView.shapeLayer.strokeColor = selectedCheckColor.cgColor
        selectedCheckView.shapeLayer.lineWidth = 2
        
        self.addSubview(selectedCircleView)
        selectedCircleView.addSubview(selectedCheckView)
        selectedCircleView.isHidden = true
        
        unselectedCircleView = CircleView(frame: circleFrame)
        unselectedCircleView.shapeLayer.path = unselectedCircleView.path.reversing().cgPath
        
        unselectedCheckView = CheckView(frame: selectedCheckView.frame)
        unselectedCheckView.shapeLayer.path = unselectedCheckView.path.reversing().cgPath
        unselectedCircleView.shapeLayer.strokeColor = unselectedBorderColor.cgColor
        unselectedCircleView.shapeLayer.lineWidth = 2
        unselectedCheckView.shapeLayer.strokeColor = unselectedCheckColor.cgColor
        unselectedCheckView.shapeLayer.lineWidth = 2
        
        self.addSubview(unselectedCircleView)
        unselectedCircleView.addSubview(unselectedCheckView)
        
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(CheckBox.clickAction(_:))
        )
        self.addGestureRecognizer(gesture)
        
        selectedViews = [selectedCircleView, selectedCheckView]
        unselectedViews = [unselectedCircleView, unselectedCheckView]
    }
    
    func clickAction(_ sender:UITapGestureRecognizer){
        self.isUserInteractionEnabled = false
        var maxDuration: CFTimeInterval = 0
        
        if isChecked {
            self.bringSubview(toFront: unselectedCircleView)
            
            for index in 0..<unselectedViews.count {
                if unselectedViews[index].animation.duration > maxDuration {
                    maxDuration = unselectedViews[index].animation.duration
                }
                
                unselectedViews[index].startAnimation()
                selectedViews[index].reverseAnimation(
                    duration: unselectedViews[index].animation.duration
                )
            }
        } else {
            self.bringSubview(toFront: selectedCircleView)
            
            for index in 0..<selectedViews.count {
                
                if selectedViews[index].animation.duration > maxDuration {
                    maxDuration = selectedViews[index].animation.duration
                }
                
                selectedViews[index].startAnimation()
                unselectedViews[index].reverseAnimation(
                    duration: selectedViews[index].animation.duration
                )
            }
        }
        
        isChecked = !isChecked
        
        DispatchQueue.main.asyncAfter(deadline: .now() + maxDuration) {
            self.isUserInteractionEnabled = true
        }
    }
    
}

