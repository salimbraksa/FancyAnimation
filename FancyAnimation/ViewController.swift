//
//  ViewController.swift
//  FancyAnimation
//
//  Created by Salim Braksa on 2/26/17.
//  Copyright © 2017 Salim Braksa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Views
    
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet weak var addButtonView: UIView!
    fileprivate var firstViewController: FirstViewController!
    
    // MARK: - Super Methods

    override func addChildViewController(_ childController: UIViewController) {
        super.addChildViewController(childController)
        
        // Configure child navigation controller
        guard let childNavigationController = childController as? UINavigationController else { return }
        childNavigationController.delegate = self
        firstViewController = childNavigationController.viewControllers.first as! FirstViewController
        
    }
    
    // MARK: - UINavigationControllerDelegate Protocol Methods
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transition = FancyTransition(containerView: containerView, sender: addButtonView)
        transition.fillColor = addButtonView.backgroundColor ?? .yellow
        transition.reversed = operation == .pop
        
        return transition
        
    }
    
    // MARK: - User Interaction
    
    @IBAction func addButtonHandler() {
        
        let identifier = "toB"
        if firstViewController.shouldPerformSegue(withIdentifier: identifier, sender: nil) {
            firstViewController.performSegue(withIdentifier: identifier, sender: nil)
        }
        
    }
    
}

extension CGRect {
    
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width/2, y: center.y - size.height/2)
        self.init(origin: origin, size: size)
    }
    
    var topLeft: CGPoint {
        return origin
    }
    
    var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }

    var allPoints: [CGPoint] {
        return [topLeft, topRight, bottomLeft, bottomRight]
    }
    
}

extension CGPoint {
    
    func distance(point: CGPoint) -> CGFloat {
        let xDist = self.x - point.x
        let yDist = self.y - point.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
}
