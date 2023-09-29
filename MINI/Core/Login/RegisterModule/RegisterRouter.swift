//
//  RegisterRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit

protocol RegisterRouterProtocol: AnyObject {
    func userDidRegister()
}

final class RegisterRouter: RegisterRouterProtocol {
    
    weak var view: UIViewController?
    
    func userDidRegister() {
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
    
}
