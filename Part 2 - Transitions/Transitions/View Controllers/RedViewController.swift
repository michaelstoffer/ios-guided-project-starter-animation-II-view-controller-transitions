//
//  RedViewController.swift
//  Transitions
//
//  Created by Spencer Curtis on 1/31/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

class RedViewController: LabelProvidingVC {
    
    @IBOutlet weak var label: UILabel!
    
    let animator = Animator()
    private var interactionController: UIPercentDrivenInteractiveTransition?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .began:
                interactionController = UIPercentDrivenInteractiveTransition()
                dismiss(sender)
            case .changed:
                let translation = sender.translation(in: view)
                let percentageComplete = abs(translation.y / view.bounds.height)
                interactionController!.update(percentageComplete)
            case .ended:
                let velocity = sender.velocity(in: view).y
                if velocity > 100 {
                    interactionController!.finish()
                } else {
                    interactionController!.cancel()
                }
            default:
                break
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.transitioningDelegate = self
        dismiss(animated: true, completion: nil)
    }
}

extension RedViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.animator
    }
}
