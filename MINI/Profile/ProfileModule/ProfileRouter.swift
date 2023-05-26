//
//  ProfileRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func userWantToLogout()
}

final class ProfileRouter: ProfileRouterProtocol {
    
    weak var view: UIViewController?
    
    func userWantToLogout() {
        UserDefaults.standard.removeObject(forKey: "authToken")
        
        let loginView = LoginBuilder.build()
        let loginScreen = UINavigationController(rootViewController: loginView)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = loginScreen
            delegate.window = window
            window.makeKeyAndVisible()
        }
        
    }
}
