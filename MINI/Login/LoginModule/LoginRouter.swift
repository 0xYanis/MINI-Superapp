//
//  LoginRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func userDidLogin()
}

final class LoginRouter: LoginRouterProtocol {
    weak var view: UIViewController?
    
    func userDidLogin() {
        let nextView = BaseTabBarController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = nextView
            window.backgroundColor = UIColor(named: "backColor")
            window.tintColor = .systemOrange
            delegate.window = window
            window.makeKeyAndVisible()
        }
    }
}
