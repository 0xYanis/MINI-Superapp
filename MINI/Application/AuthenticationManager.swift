//
//  AuthenticationManager.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class AuthenticationManager: NSObject {
    
    static func auth() -> UIViewController {
        if let _ = UserDefaults.standard.string(forKey: "authToken") {
            let mainViewController = UIViewController()
            mainViewController.view.backgroundColor = .white
            return mainViewController
        } else {
            let loginViewController = LoginBuilder.build()
            return loginViewController
        }
    }
    
}
