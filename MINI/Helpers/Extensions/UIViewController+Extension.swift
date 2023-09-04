//
//  UIViewController+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 08.08.2023.
//

import UIKit

extension UIViewController {
    
    func addNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: notification,
            object: nil
        )
    }
    
}