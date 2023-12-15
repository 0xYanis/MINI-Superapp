//
//  UINavigationController+Extension.swift
//  MINI
//
//  Created by Yanis on 12.12.2023.
//

import UIKit

extension UINavigationController {
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        self.popViewController(animated: animated)
    }
    
}
