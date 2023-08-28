//
//  AuthenticationManager.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class AuthenticationManager {
    static func auth(to window: UIWindow?) {
        if let _ = UserDefaults.standard.string(forKey: "authToken") {
            let tabbarController = BaseTabBarController()
            window?.rootViewController = tabbarController
        } else {
            let loginViewController = LoginBuilder.build()
            window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        }
    }
    
}
