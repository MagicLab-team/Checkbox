//
//  Checkbox.swift
//  Checkbox
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


@IBDesignable
class CheckBox: UIView {
    
    private (set) var selectedCircleView: CircleView!
    private (set) var selectedTickView: TickView!
    
    private (set) var unselectedCircleView: CircleView!
    private (set) var unselectedTickView: TickView!
    
    private var unselectedViews: [DrawView]!
    private var selectedViews: [DrawView]!
    
    var unselected: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        selectedCircleView = CircleView(frame: frame)
        let squareSize = frame.height <= frame.width ? frame.height : frame.width
        
        let tickViewWidth = squareSize / 3
        let tickViewHeight = squareSize / 3
        
        selectedTickView = TickView(
            frame: CGRect(
                x: frame.width / 2 - tickViewWidth / 2,
                y: frame.height / 2 - tickViewHeight / 2,
                width: tickViewWidth,
                height: tickViewHeight
            )
        )
        selectedCircleView.shapeLayer.strokeColor = UIColor.blue.cgColor
        selectedCircleView.shapeLayer.lineWidth = 2
        selectedTickView.shapeLayer.strokeColor = UIColor.green.cgColor
        selectedTickView.shapeLayer.lineWidth = 2
        selectedTickView.animation.duration = 4
        
        self.addSubview(selectedCircleView)
        selectedCircleView.addSubview(selectedTickView)
        selectedCircleView.isHidden = true
        
        unselectedCircleView = CircleView(frame: frame)
        unselectedCircleView.shapeLayer.path = unselectedCircleView.path.reversing().cgPath
        
        unselectedTickView = TickView(frame: selectedTickView.frame)
        unselectedTickView.shapeLayer.path = unselectedTickView.path.reversing().cgPath
        unselectedCircleView.shapeLayer.strokeColor = UIColor.gray.cgColor
        unselectedCircleView.shapeLayer.lineWidth = 2
        unselectedTickView.shapeLayer.strokeColor = UIColor.gray.cgColor
        unselectedTickView.shapeLayer.lineWidth = 2
        
        self.addSubview(unselectedCircleView)
        unselectedCircleView.addSubview(unselectedTickView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(CheckBox.clickAction(_:)))
        self.addGestureRecognizer(gesture)
        
        selectedViews = [selectedCircleView, selectedTickView]
        unselectedViews = [unselectedCircleView, unselectedTickView]
    }
    
    func clickAction(_ sender:UITapGestureRecognizer){
        self.isUserInteractionEnabled = false
        var maxDuration: CFTimeInterval = 0
        
        if !unselected {
            self.bringSubview(toFront: unselectedCircleView)
            
            for index in 0..<unselectedViews.count {
                if unselectedViews[index].animation.duration > maxDuration {
                    maxDuration = unselectedViews[index].animation.duration
                }
                
                unselectedViews[index].startAnimation()
                selectedViews[index].reversAnimation(
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
                unselectedViews[index].reversAnimation(
                    duration: selectedViews[index].animation.duration
                )
            }
        }
        
        unselected = !unselected
        
        DispatchQueue.main.asyncAfter(deadline: .now() + maxDuration) {
            self.isUserInteractionEnabled = true
        }
    }
    
}

