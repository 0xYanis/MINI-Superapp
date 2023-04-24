//
//  AuthenticationManager.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class AuthenticationManager: NSObject {
    
    static func auth(window: UIWindow?) -> UIViewController {
        if let _ = UserDefaults.standard.string(forKey: "authToken") {
            let tabbarController = TabbarController()
            window?.rootViewController = tabbarController
            return tabbarController
        } else {
            let loginViewController = LoginBuilder.build()
            window?.rootViewController = UINavigationController(rootViewController: loginViewController)
            return loginViewController
        }
    }
    
}
