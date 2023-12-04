//
//  UIViewController+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 08.08.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = "error_message_title".localized, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "alert_cancel".localized, style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    func addNotification(_ notification: NSNotification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: notification,
            object: object
        )
    }
    
}
