//
//  Checkbox.swift
//  Checkbox
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

public enum BorderType {
    case circle
    case square(cornerRadii: Int)
}
public enum CheckType {
    case defoult
    case circle
    case heart
    case star
    case plus
}
public enum AnimationType {
    case stroke
    case fade
    case size
}

@IBDesignable
public class CheckBox: UIView {
    
    private var unselectedBorderView: DrawView!
    private var selectedBorderView: DrawView!
    
    private var unselectedCheckView: DrawView!
    private var selectedCheckView: DrawView!
    
    private var animationType: AnimationType
    private var borderType: BorderType
    private var checkType: CheckType
    
    public var borderLineWidth: CGFloat = 2 {
        didSet {
            unselectedBorderView.shapeLayer.lineWidth = borderLineWidth
            selectedBorderView.shapeLayer.lineWidth = borderLineWidth
        }
    }
    public var checkLineWidth: CGFloat = 2 {
        didSet {
            unselectedCheckView.shapeLayer.lineWidth = checkLineWidth
            selectedCheckView.shapeLayer.lineWidth = checkLineWidth
        }
    }
    public var lineWidth: CGFloat = 2 {
        didSet {
            borderLineWidth = lineWidth
            checkLineWidth = lineWidth
        }
    }
    public var unselectedBorderColor: UIColor = UIColor.clear {
        didSet {
            unselectedBorderView.shapeLayer.strokeColor = unselectedBorderColor.cgColor
        }
    }
    public var selectedBorderColor: UIColor = UIColor.clear {
        didSet {
            selectedBorderView.shapeLayer.strokeColor = selectedBorderColor.cgColor
        }
    }
    
    public var unselectedCheckColor: UIColor = UIColor.clear {
        didSet {
            unselectedCheckView.shapeLayer.strokeColor = unselectedCheckColor.cgColor
            if checkType == .circle {
                unselectedCheckView.shapeLayer.fillColor = unselectedCheckColor.cgColor
            }
        }
    }
    
    public var selectedCheckColor: UIColor = UIColor.red {
        didSet {
            selectedCheckView.shapeLayer.strokeColor = selectedCheckColor.cgColor
            if checkType == .circle {
                selectedCheckView.shapeLayer.fillColor = selectedCheckColor.cgColor
            }
        }
    }
    public var borderAnimationDuration: TimeInterval = 0.3 {
        didSet {
            unselectedBorderView.animation.duration = borderAnimationDuration
            selectedBorderView.animation.duration = borderAnimationDuration
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
    
    public var unselectBackgroundColor: UIColor = UIColor.clear {
        didSet {
            unselectedBorderView.shapeLayer.fillColor = unselectBackgroundColor.cgColor
        }
    }
    
    public var selectBackgroundColor: UIColor = UIColor.clear {
        didSet {
            selectedBorderView.shapeLayer.fillColor = selectBackgroundColor.cgColor
        }
    }
    
    
    public init(
        frame: CGRect,
        anomationType: AnimationType,
        borderType: BorderType,
        checkType: CheckType
        ) {
        
        self.animationType = anomationType
        self.borderType = borderType
        self.checkType = checkType
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        animationType = .fade
        borderType = .square(cornerRadii: 0)
        checkType = .circle
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
        
        switch borderType {
        case .circle:
            selectedBorderView = CircleView(frame: circleFrame, animationType: self.animationType)
            unselectedBorderView = CircleView(frame: circleFrame, animationType: self.animationType)
        case let .square(cornerRadii):
            selectedBorderView = SqareView(
                frame: circleFrame,
                animationType: animationType,
                cornerRadii: cornerRadii
            )
            unselectedBorderView = SqareView(
                frame: circleFrame, animationType:
                animationType,
                cornerRadii: cornerRadii
            )
        }
        
        let squareSize = frame.height <= frame.width ? frame.height : frame.width
        
        let tickViewWidth = squareSize / 2
        let tickViewHeight = squareSize / 2
        
        let checkViewFrame = CGRect(
            x: frame.width / 2 - tickViewWidth / 2,
            y: frame.height / 2 - tickViewHeight / 2,
            width: tickViewWidth,
            height: tickViewHeight
        )
        
        switch checkType {
        case .plus:
            selectedCheckView = PlusView(frame: checkViewFrame, animationType: animationType)
            unselectedCheckView = PlusView(frame: checkViewFrame, animationType: animationType)
        case .star:
            selectedCheckView = StarView(frame: checkViewFrame, animationType: animationType)
            unselectedCheckView = StarView(frame: checkViewFrame, animationType: animationType)
        case .circle:
            selectedCheckView = CircleView(frame: checkViewFrame, animationType: animationType)
            unselectedCheckView = CircleView(frame: checkViewFrame, animationType: animationType)
        case .heart:
            selectedCheckView = HeartView(frame: checkViewFrame, animationType: animationType)
            unselectedCheckView = HeartView(frame: checkViewFrame, animationType: animationType)
        case .defoult:
            selectedCheckView = CheckView(
                frame: checkViewFrame,
                animationType: self.animationType
            )
            unselectedCheckView = CheckView(
                frame: checkViewFrame,
                animationType: self.animationType
            )
        }
        
        
        selectedBorderView.shapeLayer.strokeColor = selectedBorderColor.cgColor
        selectedBorderView.shapeLayer.lineWidth = borderLineWidth
        selectedBorderView.shapeLayer.fillColor = selectBackgroundColor.cgColor
        
        selectedCheckView.shapeLayer.strokeColor = selectedCheckColor.cgColor
        selectedCheckView.shapeLayer.lineWidth = borderLineWidth
        
        self.addSubview(selectedBorderView)
        selectedBorderView.addSubview(selectedCheckView)
        selectedBorderView.isHidden = true
        
        unselectedBorderView.shapeLayer.path = unselectedBorderView.path.reversing().cgPath
        
        
        unselectedCheckView.shapeLayer.path = unselectedCheckView.path.reversing().cgPath
        unselectedBorderView.shapeLayer.strokeColor = unselectedBorderColor.cgColor
        unselectedBorderView.shapeLayer.lineWidth = checkLineWidth
        unselectedBorderView.shapeLayer.fillColor = unselectBackgroundColor.cgColor
        unselectedCheckView.shapeLayer.strokeColor = unselectedCheckColor.cgColor
        unselectedCheckView.shapeLayer.lineWidth = checkLineWidth
        
        self.addSubview(unselectedBorderView)
        unselectedBorderView.addSubview(unselectedCheckView)
        
        
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(CheckBox.clickAction(_:))
        )
        self.addGestureRecognizer(gesture)
        
        
    }
    
    func clickAction(_ sender:UITapGestureRecognizer){
        
        self.isUserInteractionEnabled = false
        var checkDuration: CFTimeInterval = 0
        var borderDuration: CFTimeInterval = 0
        var maxDuration: CFTimeInterval = 0
        
        if isChecked {
            self.bringSubview(toFront: unselectedBorderView)
            
            checkDuration = unselectedCheckView.animation.duration
            borderDuration = unselectedBorderView.animation.duration
            maxDuration = checkDuration >= borderDuration ? checkDuration : borderDuration
            
            unselectedCheckView.startAnimation()
            unselectedBorderView.startAnimation()
            
            selectedCheckView.reverseAnimation(duration: selectedCheckView.animation.duration)
            selectedBorderView.reverseAnimation(duration: selectedBorderView.animation.duration)
            
        } else {
            self.bringSubview(toFront: selectedBorderView)
            
            checkDuration = selectedCheckView.animation.duration
            borderDuration = selectedBorderView.animation.duration
            
            selectedCheckView.startAnimation()
            selectedBorderView.startAnimation()
            
            unselectedCheckView.reverseAnimation(duration: unselectedCheckView.animation.duration)
            unselectedBorderView.reverseAnimation(duration: unselectedBorderView.animation.duration)
        }
        
        maxDuration = checkDuration >= borderDuration ? checkDuration : borderDuration
        isChecked = !isChecked
        
        DispatchQueue.main.asyncAfter(deadline: .now() + maxDuration) {
            self.isUserInteractionEnabled = true
        }
        
    }
    
}

