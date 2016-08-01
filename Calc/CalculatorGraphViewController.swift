//
//  CalculatorGraphViewController.swift
//  Calc
//
//  Created by Dilpreet Singh on 11/07/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit
import CoreGraphics

class CalculatorGraphViewController: UIViewController, UISplitViewControllerDelegate {
    
    @IBOutlet weak var graphView: CalcView!
    
    var function: String = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override  func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.function = function
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}