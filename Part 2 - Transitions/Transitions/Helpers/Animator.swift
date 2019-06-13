//
//  Animator.swift
//  Transitions
//
//  Created by Michael Stoffer on 6/12/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

typealias LabelProvidingVC = LabelProviding & UIViewController

class Animator: NSObject {
    
}

extension Animator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // How long should your transition run?
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Label that is going to be animated
        guard let fromVC = transitionContext.viewController(forKey: .from) as? LabelProvidingVC,
            let toVC = transitionContext.viewController(forKey: .to) as? LabelProvidingVC,
            let toView = transitionContext.view(forKey: .to) else { return }
        
        // The view that holds the label that we are animating from one position to the other
        let containerView = transitionContext.containerView
        
        // Get the final frame when the animation is done
        let toViewEndFrame = transitionContext.finalFrame(for: toVC)
        
        // Setup the final frame
        containerView.addSubview(toView)
        toView.frame = toViewEndFrame
        toView.alpha = 0.0
        
        // Figure out where the label should start and where it should end up
        let fromLabel = fromVC.label!
        let toLabel = toVC.label!
        
        // Hide our REAL labels so they don't show up during the transition
        fromLabel.alpha = 0.0
        toLabel.alpha = 0.0
        
        // Setup the initial frame
        let transitioningLabelInitialFrame = containerView.convert(fromLabel.bounds, from: fromLabel)
        
        // The transitioning label will be in exactly the same location as the fromLabel
        let transitioningLabel = UILabel(frame: transitioningLabelInitialFrame)
        transitioningLabel.textColor = .white
        transitioningLabel.font = fromLabel.font
        transitioningLabel.text = fromLabel.text
        containerView.addSubview(transitioningLabel)
        
        // Get out duration from the func transistionDuration
        let transistionDuration = self.transitionDuration(using: transitionContext)
        
        toView.layoutIfNeeded()
        
        // Perform the animation
        UIView.animate(withDuration: transistionDuration, animations: {
            let transitioningLabelEndFrame = containerView.convert(toLabel.bounds, from: toLabel)
            transitioningLabel.frame = transitioningLabelEndFrame
            toView.alpha = 1.0
        }) { (_) in
            toLabel.alpha = 1.0
            fromLabel.alpha = 1.0
            transitioningLabel.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
