//
//  AuthenticationManager.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class AuthenticationManager {
    
    private var fbAuthManager: FBAuthProtocol?
    
    init() { self.fbAuthManager = FBAuthManager() }
    
    func auth(_ window: UIWindow?) {
        if let _ = fbAuthManager?.currentUser {
            let tabbarController = BaseTabBarController()
            window?.rootViewController = tabbarController
        } else {
            let login = LoginBuilder.build()
            let root = UINavigationController(rootViewController: login)
            window?.rootViewController = root
        }
    }
    
}
