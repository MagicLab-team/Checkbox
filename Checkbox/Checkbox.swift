//
//  Checkbox.swift
//  Checkbox
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

public enum BorderType {
    case circle(animation: AnimationType)
    case square(cornerRadii: Int, animation: AnimationType)
    case none
}
public enum CheckType {
    case defoult(animation: AnimationType)
    case circle(circleAnimation: CircleAnimationType)
    case heart(animation: AnimationType)
    case star(animation: AnimationType)
    case plus(animation: AnimationType)
}
public enum AnimationType {
    case stroke
    case fade
    case size
}
public enum CircleAnimationType {
    case fade
    case size
    
    func animationType() -> AnimationType {
        switch self {
        case .fade:
            return .fade
        case .size:
            return .size
        }
    }
}

@IBDesignable
public class CheckBox: UIView {
    
    private var unselectedBorderView: DrawView?
    private var selectedBorderView: DrawView?
    
    private var unselectedCheckView: DrawView!
    private var selectedCheckView: DrawView!
    
    private var borderType: BorderType
    private var checkType: CheckType
    
    public var borderLineWidth: CGFloat = 2 {
        didSet {
            unselectedBorderView?.shapeLayer.lineWidth = borderLineWidth
            selectedBorderView?.shapeLayer.lineWidth = borderLineWidth
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
            unselectedBorderView?.shapeLayer.strokeColor = unselectedBorderColor.cgColor
        }
    }
    public var selectedBorderColor: UIColor = UIColor.clear {
        didSet {
            selectedBorderView?.shapeLayer.strokeColor = selectedBorderColor.cgColor
        }
    }
    
    public var unselectedCheckColor: UIColor = UIColor.clear {
        didSet {
            unselectedCheckView.shapeLayer.strokeColor = unselectedCheckColor.cgColor
            switch checkType {
            case .circle(_):
                unselectedCheckView.shapeLayer.fillColor = unselectedCheckColor.cgColor
            default:
                break
            }
        }
    }
    
    public var selectedCheckColor: UIColor = UIColor.red {
        didSet {
            selectedCheckView.shapeLayer.strokeColor = selectedCheckColor.cgColor
            switch checkType {
            case .circle(_):
                selectedCheckView.shapeLayer.fillColor = selectedCheckColor.cgColor
            default:
                break
            }
        }
    }
    public var borderAnimationDuration: TimeInterval = 0.3 {
        didSet {
            unselectedBorderView?.animation.duration = borderAnimationDuration
            selectedBorderView?.animation.duration = borderAnimationDuration
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
            unselectedBorderView?.shapeLayer.fillColor = unselectBackgroundColor.cgColor
        }
    }
    
    public var selectBackgroundColor: UIColor = UIColor.clear {
        didSet {
            selectedBorderView?.shapeLayer.fillColor = selectBackgroundColor.cgColor
        }
    }
    
    public func check() {
        check(isChecked: true)
    }
    
    public func uncheck() {
        check(isChecked: false)
    }
    
    
    public init(
        frame: CGRect,
        borderType: BorderType,
        checkType: CheckType
        ) {
        
        self.borderType = borderType
        self.checkType = checkType
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        borderType = .square(cornerRadii: 0, animation: .fade)
        checkType = .circle(circleAnimation: .fade)
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
        
        let squareSize = frame.height <= frame.width ? frame.height : frame.width
        
        let tickViewWidth = squareSize / 2
        let tickViewHeight = squareSize / 2
        
        var checkViewFrame = CGRect(
            x: frame.width / 2 - tickViewWidth / 2,
            y: frame.height / 2 - tickViewHeight / 2,
            width: tickViewWidth,
            height: tickViewHeight
        )
        
        switch borderType {
        case let .circle(animationType):
            selectedBorderView = CircleView(frame: circleFrame, animationType: animationType)
            unselectedBorderView = CircleView(frame: circleFrame, animationType: animationType)
        case let .square(cornerRadii, animationType):
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
        case .none:
            checkViewFrame = CGRect(
                x: frame.width / 2 - tickViewWidth,
                y: frame.height / 2 - tickViewHeight,
                width: tickViewWidth*2,
                height: tickViewHeight*2
            )
        }
    
        
        switch checkType {
        case let .plus(animationType):
            selectedCheckView = PlusView(frame: checkViewFrame, animationType: animationType)
            unselectedCheckView = PlusView(frame: checkViewFrame, animationType: animationType)
        case let .star(animationType):
            selectedCheckView = StarView(frame: checkViewFrame, animationType: animationType)
            unselectedCheckView = StarView(frame: checkViewFrame, animationType: animationType)
        case let .circle(circleAnimation):
            selectedCheckView = CircleView(
                frame: checkViewFrame,
                animationType: circleAnimation.animationType()
            )
            unselectedCheckView = CircleView(
                frame: checkViewFrame,
                animationType: circleAnimation.animationType()
            )
        case let .heart(animationType):
            selectedCheckView = HeartView(frame: checkViewFrame, animationType: animationType)
            unselectedCheckView = HeartView(frame: checkViewFrame, animationType: animationType)
        case let .defoult(animationType):
            selectedCheckView = CheckView(
                frame: checkViewFrame,
                animationType: animationType
            )
            unselectedCheckView = CheckView(
                frame: checkViewFrame,
                animationType: animationType
            )
        }
        
        setupSelectedBorderView()
        setupSelectedCheckView()
        setupUnselectedBorderView()
        setupUnselectedCheckView()

        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(CheckBox.clickAction(_:))
        )
        self.addGestureRecognizer(gesture)
    }
    
    private func setupUnselectedBorderView() {
        guard let unselectedBorderView = unselectedBorderView else {
            return
        }
        unselectedBorderView.shapeLayer.path = unselectedBorderView.path.reversing().cgPath
        unselectedBorderView.shapeLayer.strokeColor = unselectedBorderColor.cgColor
        unselectedBorderView.shapeLayer.lineWidth = checkLineWidth
        unselectedBorderView.shapeLayer.fillColor = unselectBackgroundColor.cgColor
        self.addSubview(unselectedBorderView)
    }
    
    private func setupSelectedBorderView() {
        guard let selectedBorderView = selectedBorderView else {
            return
        }
        selectedBorderView.shapeLayer.strokeColor = selectedBorderColor.cgColor
        selectedBorderView.shapeLayer.lineWidth = borderLineWidth
        selectedBorderView.shapeLayer.fillColor = selectBackgroundColor.cgColor
        self.addSubview(selectedBorderView)
        selectedBorderView.isHidden = true
    }
    
    private func setupSelectedCheckView() {
        selectedCheckView.shapeLayer.strokeColor = selectedCheckColor.cgColor
        selectedCheckView.shapeLayer.lineWidth = borderLineWidth
        self.addSubview(selectedCheckView)
    }
    
    private func setupUnselectedCheckView() {
        unselectedCheckView.shapeLayer.path = unselectedCheckView.path.reversing().cgPath
        unselectedCheckView.shapeLayer.strokeColor = unselectedCheckColor.cgColor
        unselectedCheckView.shapeLayer.lineWidth = checkLineWidth
        self.addSubview(unselectedCheckView)
    }
    
    func clickAction(_ sender: UITapGestureRecognizer) {
        check(isChecked: !isChecked)
    }
    
    private func check(isChecked: Bool) {
        self.isUserInteractionEnabled = false
        var checkDuration: CFTimeInterval = 0
        var borderDuration: CFTimeInterval = 0
        var maxDuration: CFTimeInterval = 0
        
        if !isChecked {
            self.bringSubview(toFront: unselectedBorderView!)
            
            checkDuration = unselectedCheckView.animation.duration
            borderDuration = unselectedBorderView!.animation.duration
            maxDuration = checkDuration >= borderDuration ? checkDuration : borderDuration
            
            unselectedCheckView.startAnimation()
            unselectedBorderView?.startAnimation()
            
            selectedCheckView.reverseAnimation(duration: selectedCheckView.animation.duration)
            selectedBorderView?.reverseAnimation(duration: selectedBorderView!.animation.duration)
            
        } else {
            self.bringSubview(toFront: selectedBorderView!)
            
            checkDuration = selectedCheckView.animation.duration
            borderDuration = selectedBorderView!.animation.duration
            
            selectedCheckView.startAnimation()
            selectedBorderView?.startAnimation()
            
            unselectedCheckView.reverseAnimation(duration: unselectedCheckView.animation.duration)
            unselectedBorderView?.reverseAnimation(
                duration: unselectedBorderView!.animation.duration
            )
        }
        
        maxDuration = checkDuration >= borderDuration ? checkDuration : borderDuration
        self.isChecked = isChecked
        
        DispatchQueue.main.asyncAfter(deadline: .now() + maxDuration) {
            self.isUserInteractionEnabled = true
        }
    }
}

