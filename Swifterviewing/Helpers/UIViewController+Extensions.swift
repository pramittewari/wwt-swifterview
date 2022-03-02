//
//  UIViewController+Extensions.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {

    // MARK: - Alert Methods

    private func showAlert(forTitle title: String = "",
                           message: String,
                           actions: [UIAlertAction]) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)

        actions.forEach { alertController.addAction($0) }

        alertController.modalPresentationStyle = .custom
        alertController.modalTransitionStyle = .crossDissolve
        present(alertController, animated: true, completion: nil)
    }

    /// Method to show native alert
    ///
    /// - Parameters:
    ///   - title: title of Alert
    ///   - message: description of the Alert
    ///   - buttonTitles: Array of buttons
    ///   - customAlertViewTapButtonBlock: returns completion handler
    ///   - isHighPriority: Its a unique parameter that dismiss any alert or view presenting
    ///     over the current view controller. Only to be used for high priority alerts.
    func showAlert(forTitle title: String = "",
                   message: String,
                   buttonTitles: [String],
                   customAlertViewTapButtonBlock: ((Int) -> Void)?, isHighPriority: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            var actions = [UIAlertAction]()
            for buttonIndex in 0..<(buttonTitles.count) {
                let alertAction = UIAlertAction(title: buttonTitles[buttonIndex],
                                                style: UIAlertAction.Style.default,
                                                handler: { _ in
                                                    customAlertViewTapButtonBlock?(buttonIndex)
                })
                actions.append(alertAction)
            }
            if isHighPriority {
                guard let presentedVC = self?.presentedViewController else {
                    self?.showAlert(forTitle: title, message: message, actions: actions)
                    return
                }
                presentedVC.dismiss(animated: true, completion: {
                    self?.showAlert(forTitle: title, message: message, actions: actions)
                })
            } else {
                self?.showAlert(forTitle: title, message: message, actions: actions)
            }
        }
    }

    /**
     Call to show an alert with a single OK button and no action blocks attached.

     - parameter message: The message to be shown in the alert dialog
     */
    func showOkAlert(message: String) {

        showAlert(message: message,
                  buttonTitles: [R.string.localizable.alertActionOkay()],
                  customAlertViewTapButtonBlock: nil)
    }
    
    // MARK: - HUD Methods
    
    func showProgressHudView(title: String = "", view: UIView? = nil) {
        hideProgressHudView()
        SVProgressHUD.setContainerView(view ?? self.view)
        SVProgressHUD.setForegroundColor(UIColor.label)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setFadeInAnimationDuration(0.25)
        SVProgressHUD.setFadeOutAnimationDuration(0.25)
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func hideProgressHudView(view: UIView? = nil) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
