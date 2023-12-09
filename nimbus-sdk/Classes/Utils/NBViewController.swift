//
//  NBViewController.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 05/09/23.
//

import UIKit

public extension UIViewController {
    
    /// Adds child view controller to the parent.
    ///
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIViewController {

    func topMostViewController() -> UIViewController? {
        return topViewController(controller: self)
    }
    
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIWindow {
    func viewControllerInStack<T: UIViewController>(of type: T.Type? = nil) -> T? {

        if let vc = rootViewController as? T {
            return vc
        } else if let vc = rootViewController?.presentedViewController as? T {
            return vc
        } else if let vc = rootViewController?.children {
            return vc.lazy.compactMap { $0 as? T }.first
        }
        
        return nil
    }
}
