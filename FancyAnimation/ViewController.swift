//
//  ViewController.swift
//  FancyAnimation
//
//  Created by Salim Braksa on 2/26/17.
//  Copyright © 2017 Salim Braksa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Child View Controller
    
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
        return nil
    }
    
    // MARK: - User Interaction
    
    @IBAction func addButton() {
        firstViewController.performSegue(withIdentifier: "toB", sender: nil)
    }
    
}

