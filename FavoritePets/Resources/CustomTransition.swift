//
//  CustomAnimation.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let controllers: [UIViewController]?
    private let duaration: Double = 0.25

    init(viewControllers: [UIViewController]?) {
        controllers = viewControllers
    }
    
    private func getIndex(of viewController: UIViewController) -> Int? {
        if let controllers = controllers {
            for (index, currentController) in controllers.enumerated() {
                if currentController == viewController { return index }
            }
        }
        return nil
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(duaration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let tempView = fromVC.view,
            let fromIndex = getIndex(of: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(of: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromVCFrameEnd = frame
        var toVCFrameStart = frame
        tempView.alpha = 0.4
        fromVCFrameEnd.origin.x = fromIndex < toIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toVCFrameStart.origin.x = fromIndex < toIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toVCFrameStart

            transitionContext.containerView.addSubview(toView)
            
            UIView.animate(withDuration: self.duaration, delay: 0.08, animations: {
                
                tempView.frame = fromVCFrameEnd
                toView.frame = frame
                
            }, completion: { success in
                tempView.alpha = 1
                tempView.removeFromSuperview()
                transitionContext.completeTransition(success)
                
            })
    }

}
