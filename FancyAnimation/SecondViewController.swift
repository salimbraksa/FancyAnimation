//
//  SecondViewController.swift
//  FancyAnimation
//
//  Created by Salim Braksa on 2/26/17.
//  Copyright © 2017 Salim Braksa. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func back() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
}
