//
//  RegisterBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit

final class RegisterBuilder {
    
    static func build(coordinator: LoginCoordinator) -> UIViewController {
        let keychain = KeyChainService()
        let authManager = FBAuthManager()
        let firestore = FBFirestoreManager()
        
        let view = RegisterViewController()
        let router = RegisterRouter(view: view, coordinator: coordinator)
        let interactor = RegisterInteractor(keychain: keychain, authManager: authManager, firestore: firestore)
        let presenter = RegisterPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
