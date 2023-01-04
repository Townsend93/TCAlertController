//
//  TCAlertAnimator.swift
//  TCAlertController
//
//  Created by ls_tc on 2022/12/23.
//

import Foundation
import UIKit

class TCAlertAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private weak var dimissViewController: UIViewController?
    
    private var horizontalInset: CGFloat
    
    init(horizontalInset: CGFloat = 30) {
        self.horizontalInset = horizontalInset
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromController = transitionContext.viewController(forKey: .from) else { return }
        let isDismiss = fromController.classForCoder == TCAlertController.self
        
        dimissViewController = fromController
        isDismiss ? dimissTransition(transitionContext: transitionContext) : presentTransition(transitionContext: transitionContext)
        
    }
    
    private func presentTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toController = transitionContext.viewController(forKey: .to) as? TCAlertController, let toView = transitionContext.view(forKey: .to) else { return }
        let containerView = transitionContext.containerView
       
        toView.frame = containerView.bounds
        containerView.addSubview(toView)
        
        toController.containerView.transform = CGAffineTransform(scaleX: 0.6, y:  0.6)
        toController.containerView.alpha = 0.0
        
        toController.dimimingView.alpha = 0
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, animations: {
            toController.containerView.transform = .identity
            toController.containerView.alpha = 1.0
            toController.dimimingView.alpha = 1.0
        }, completion: { finish in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        })
    }
    
    private func dimissTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromController = transitionContext.viewController(forKey: .from) as? TCAlertController else { return }

        let duration = 0.1
        UIView.animate(withDuration: duration, delay: 0, animations: {
            fromController.view.alpha = 0
        }, completion: { finish in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
            fromController.view.removeFromSuperview()
        })
        
    }
    
    
    @objc
    private func dimissAction() {
        debugPrint("dimiss")
        dimissViewController?.dismiss(animated: true)
    }
    
}
