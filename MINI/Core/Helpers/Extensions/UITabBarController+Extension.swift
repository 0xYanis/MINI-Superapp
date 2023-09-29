//
//  UITabBarController+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

extension UITabBarController {
    
    func hideTabBar() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.tabBar.frame.origin.y = self.view.frame.maxY
        }
    }
    
    func showTabBar() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.tabBar.frame.origin.y = self.view.frame.maxY - self.tabBar.frame.size.height
        }
    }
    
}
