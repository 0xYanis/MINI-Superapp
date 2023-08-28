//
//  AuthenticationManager.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class AuthenticationManager {
    
    private var fbAuthManager: FBAuthProtocol?
    private var keyChain: KeyChainServiceProtocol?
    
    init() {
        self.fbAuthManager = FBAuthManager()
        self.keyChain = KeyChainService()
    }
    
    func auth(_ window: UIWindow?) {
        if let _ = userUID {
            let tabbarController = BaseTabBarController()
            window?.rootViewController = tabbarController
        } else {
            let login = LoginBuilder.build()
            let root = UINavigationController(rootViewController: login)
            window?.rootViewController = root
        }
    }
    
    private var userUID: String? {
        return keyChain?.getValue(forKey: "uid")
    }
    
}
