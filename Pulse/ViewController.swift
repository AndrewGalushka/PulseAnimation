//
//  ViewController.swift
//  Pulse
//
//  Created by admin on 4/14/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pulseView: UIView!
    
    var isCornerRadiusSet = false
    
    var pulseViewLayers = [CALayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpPulseView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.isCornerRadiusSet {
            
            isCornerRadiusSet = true
            
            let cornerRadius = CABasicAnimation(keyPath: "cornerRadius")
            cornerRadius.fromValue = self.pulseView.layer.cornerRadius
            cornerRadius.toValue = max(pulseView.frame.height, pulseView.frame.width) / 2
            cornerRadius.duration = 1.5
            cornerRadius.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            cornerRadius.fillMode = kCAFillModeForwards
            cornerRadius.delegate = self
            cornerRadius.isRemovedOnCompletion = false
            
            pulseView.layer.add(cornerRadius, forKey: "cornerRadius")
        }
    }
    
    func setUpPulseView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pulseViewTapGestureRecognizer))
        pulseView.addGestureRecognizer(tapGesture)
    }
    
    func pulseViewTapGestureRecognizer() {
//        let pulseLayer = CAShapeLayer()
//        pulseLayer.path = UIBezierPath(roundedRect: pulseView.bounds, cornerRadius: pulseView.layer.cornerRadius).cgPath
//        pulseLayer.position = pulseView.center
//        pulseLayer.fillColor = UIColor.random().cgColor
        
        let animationDuration = 3.0
        
        let pulseLayer = CALayer()
        pulseLayer.frame = pulseView.bounds
        pulseLayer.backgroundColor = UIColor.random().cgColor
        
        pulseLayer.cornerRadius = pulseView.layer.cornerRadius
        pulseViewLayers.append(pulseLayer)
        
        pulseView.layer.addSublayer(pulseLayer)
        
        let oldSize = pulseLayer.bounds
        var newSize = oldSize
        newSize.size = CGSize(width: newSize.size.width * 3, height: newSize.size.height * 3)
        
        let scaleAnimation = CABasicAnimation(keyPath: "bounds")
        scaleAnimation.fromValue = oldSize
        scaleAnimation.toValue = newSize
        scaleAnimation.duration = animationDuration
        
        let cornerRadius = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadius.fromValue = pulseLayer.cornerRadius
        cornerRadius.toValue = max(newSize.height, newSize.width) / 2
        cornerRadius.duration = animationDuration
        
        let position = CABasicAnimation(keyPath: "position")
        position.fromValue = pulseLayer.position
        position.toValue = pulseLayer.position
        position.duration = animationDuration
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.byValue = -1.0
        opacityAnimation.duration = animationDuration
        
        let colorChangeAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorChangeAnimation.fromValue = pulseLayer.backgroundColor
        colorChangeAnimation.toValue = UIColor.random().cgColor
        colorChangeAnimation.duration = animationDuration
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [cornerRadius, scaleAnimation, opacityAnimation, position]
        animationGroup.duration = animationDuration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.autoreverses = true
        animationGroup.repeatCount = 2
        animationGroup.delegate = self
        
        pulseLayer.add(animationGroup, forKey: "pulseAnimation")
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag {
            
            if anim == pulseView.layer.animation(forKey: "cornerRadius") {
                
                pulseView.layer.removeAnimation(forKey: "cornerRadius")
                pulseView.layer.cornerRadius = max(pulseView.frame.height, pulseView.frame.width) / 2
            }
            else {
                
                for pulseLayer in pulseViewLayers {
                    
                    if anim == pulseLayer.animation(forKey: "pulseAnimation") {
                        pulseLayer.removeFromSuperlayer()
                        
                        let index = pulseViewLayers.index(of: pulseLayer)
                        
                        if let index = index {
                            pulseViewLayers.remove(at: index)
                        }
                    }
                }
            }
        }
    }
}
