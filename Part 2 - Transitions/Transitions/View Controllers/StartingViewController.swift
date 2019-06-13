//
//  ViewController.swift
//  Transitions
//
//  Created by Spencer Curtis on 1/31/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

class StartingViewController: LabelProvidingVC {

    @IBOutlet weak var label: UILabel!
    
    let animator = Animator()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Self because startinVC is the segue we are transitioning from
        segue.destination.transitioningDelegate = self
    }
}

extension StartingViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Tells system going to be using custom animation
        return animator
    }
}
