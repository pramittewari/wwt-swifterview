//
//  UIViewController+Extensions.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyJSON

class NotificationService: NSObject {
    
    // MARK: - Variable
    private var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    private var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    
        
    // MARK: - Alert methods
    func showInternetAlert() {
        showOkAlert(message: R.string.localizable.networkCheck())
    }
    
    func showOkAlert(message: String) {
        DispatchQueue.main.async {
            guard let topVC = UIApplication.getTopMostViewController() else { return }
            topVC.showOkAlert(message: message)
        }
    }
    
}

extension UIApplication {
    
    /// Gets the top most VC from the base.
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
