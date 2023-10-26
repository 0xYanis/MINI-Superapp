//
//  LoginBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

final class LoginBuilder {
    static func build(coordinator: AuthCoordinator) -> UIViewController {
        let viewController = LoginViewController()
        let router = LoginRouter(view: viewController, coordinator: coordinator)
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(interactor: interactor, router: router)
        let biometryService = BiometryService()
        let keychainService = KeyChainService()
        let fbAuthManager = FBAuthManager()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.keychainService = keychainService
        interactor.biometryService = biometryService
        interactor.fbAuthManager = fbAuthManager
        
        return viewController
    }
    
}
