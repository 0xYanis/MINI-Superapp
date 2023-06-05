//
//  RegisterRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit

protocol RegisterRouterProtocol: AnyObject {
    func userDidRegister()
    func goToLoginView()
    
}

final class RegisterRouter: RegisterRouterProtocol {
    
    weak var view: UIViewController?
    
    func userDidRegister() {
        let nextView = BaseTabBarController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = nextView
            window.overrideUserInterfaceStyle = .dark
            window.backgroundColor = UIColor(named: "backColor")
            window.tintColor = .systemOrange
            delegate.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func goToLoginView() {
        let loginView = LoginBuilder.build()
        view?.navigationController?.pushViewController(loginView, animated: true)
    }
}
