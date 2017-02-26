//
//  FancyTransition.swift
//  FancyAnimation
//
//  Created by Salim Braksa on 2/26/17.
//  Copyright © 2017 Salim Braksa. All rights reserved.
//

import UIKit

class FancyTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    // MARK: - Properties
    
    var reversed = false
    var fillColor: UIColor = .yellow
    
    weak var containerView: UIView!
    weak var sender: UIView!
    
    lazy private var fillLocation: CGPoint = {
        return CGPoint(x: self.containerView.bounds.width * 0.6, y: self.containerView.bounds.height * 0.4)
    }()
    
    private var duration: TimeInterval {
        return transitionDuration(using: nil)
    }
    
    // MARK: - initializer
    
    private override init() {
        super.init()
    }
    
    init(containerView: UIView, sender: UIView) {
        self.containerView = containerView
        self.sender = sender
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning Protocol Methods
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
        let destinationVC = transitionContext.viewController(forKey: .to),
        let sourceVC = transitionContext.viewController(forKey: .from),
        let sourceView = sourceVC.view,
        let destinationView = destinationVC.view
        else { return }
        destinationView.frame = transitionContext.finalFrame(for: destinationVC)
        
        // Start a transaction
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            transitionContext.completeTransition(true)
        }
        
        // Fill In or Out the container view
        
        if reversed {
            fillOutAnimation(view: containerView)
        } else {
            fillInAnimation(view: containerView)
        }
        
        // Apply a simple transition between source & destination view
        
        UIView.transition(from: sourceView, to: destinationView, duration: duration, options: .transitionCrossDissolve)
        
        // Commit transaction
        
        CATransaction.commit()
        
    }
    
    // MARK: - Filling Animation
    
    private func fillOutAnimation(view: UIView) {
    
        let ovalLayer = containerView.layer.sublayers!.first!
        ovalLayer.transform = CATransform3DMakeScale(0.01, 0.01, 1)
        let expandAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        expandAnimation.fromValue = CATransform3DIdentity
        ovalLayer.transform = CATransform3DMakeScale(0.001, 0.001, 1)
        expandAnimation.toValue = ovalLayer.transform
        expandAnimation.duration = 0.7 * duration
        expandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        expandAnimation.delegate = self
        ovalLayer.add(expandAnimation, forKey: "fill animation")
    
    }
    
    private func fillInAnimation(view: UIView) {
        
        // Compute oval's center and radius
        let center = fillLocation
        var radius: CGFloat = 0
        for point in containerView.bounds.allPoints {
            radius = max(radius, point.distance(point: center))
        }
        
        // Set the shape layer
        let ovalLayer = CAShapeLayer()
        let size = CGSize(width: 2*radius, height: 2*radius)
        ovalLayer.frame = CGRect(center: center, size: size)
        ovalLayer.fillColor = fillColor.cgColor
        let ovalPath = CGPath(ellipseIn: ovalLayer.bounds, transform: nil)
        ovalLayer.path = ovalPath
        containerView.layer.insertSublayer(ovalLayer, at: 0)
        
        // Animate ovalLayer
        let expandAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        expandAnimation.fromValue = CATransform3DMakeScale(0.01, 0.01, 1)
        expandAnimation.toValue = CATransform3DIdentity
        expandAnimation.duration = 0.7 * duration
        expandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        ovalLayer.add(expandAnimation, forKey: "fill animation")
        
    }
    
    // MARK: - CAAnimationDelegate Protocol Methods
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let ovalLayer = containerView.layer.sublayers?.first else { return }
        ovalLayer.removeFromSuperlayer()
    }
    
}
