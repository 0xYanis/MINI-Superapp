//
//  UIAlertController+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

extension UIAlertController {
    func showAlert(title: String, message: String, from viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "alert_cancel".localized, style: .cancel, handler: nil)
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
