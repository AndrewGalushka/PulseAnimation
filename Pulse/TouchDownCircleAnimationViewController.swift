//
//  TouchDownCircleAnimationViewController.swift
//  Pulse
//
//  Created by admin on 4/15/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class TouchDownCircleAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTouchDownCircleDrawingGesture()
    }
    
    func addTouchDownCircleDrawingGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(touchDownCircleDrawingGestureHandler)))
    }
    
    func touchDownCircleDrawingGestureHandler(tapGesure tap: UITapGestureRecognizer) {
        
        let gestureLocation = tap.location(in: view)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: gestureLocation.x, y: gestureLocation.y, width: 200, height: 200)
        shapeLayer.position = gestureLocation
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.random().cgColor
        shapeLayer.strokeEnd = 0.0
        shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 200, height: 200)).cgPath
        
        view.layer.addSublayer(shapeLayer)
        
        let circleDrawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleDrawAnimation.toValue = 1.0
        circleDrawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleDrawAnimation.duration = 2.0
        circleDrawAnimation.autoreverses = true
        circleDrawAnimation.repeatCount = 2
        
        shapeLayer.add(circleDrawAnimation, forKey: nil)
    }
}
