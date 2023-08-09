//
//  ProfileRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func userWantToLogout()
    func userWantToDetailView(of type: ProfileDetails)
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
            window.backgroundColor = .backMINI
            window.tintColor = .tintMINI
            delegate.window = window
            window.makeKeyAndVisible()
        }
        
    }
    
    func userWantToDetailView(of type: ProfileDetails) {
        let defView = UIViewController()
        defView.view.backgroundColor = .back2MINI
        
        switch type {
        case .favorites:
            goToDetailView(to: defView)
        case .tickets:
            goToDetailView(to: defView)
        case .orders:
            goToDetailView(to: defView)
        case .transactions:
            goToDetailView(to: defView)
            
        case .language:
            goToDetailView(to: defView)
        case .password:
            goToDetailView(to: PasswordBuilder.build())
        case .support:
            goToDetailView(to: defView)
        default: return
        }
    }
    
    private func goToDetailView(to module: UIViewController) {
        view?.navigationController?.pushViewController(
            module,
            animated: true
        )
    }
    
}
