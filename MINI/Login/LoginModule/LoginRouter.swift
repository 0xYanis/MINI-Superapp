//
//  LoginRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func userDidLogin()
    func goToRegisterView()
}

final class LoginRouter: LoginRouterProtocol {
    weak var view: UIViewController?
    
    func userDidLogin() {
        let nextView = BaseTabBarController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = nextView
            window.backgroundColor = .backMINI
            window.tintColor = .tintMINI
            delegate.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func goToRegisterView() {
        let registerView = RegisterBuilder.build()
        view?.navigationController?.pushViewController(registerView, animated: true)
    }
}
