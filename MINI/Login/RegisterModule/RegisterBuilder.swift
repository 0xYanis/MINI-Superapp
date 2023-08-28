//
//  RegisterBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit

final class RegisterBuilder {
    static func build() -> UIViewController {
        let view = RegisterViewController()
        let router = RegisterRouter()
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter(router: router, interactor: interactor)
        let keyChain = KeyChainService()
        let fbAuthManager = FBAuthManager()
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        interactor.keychainService = keyChain
        interactor.fbAuthManager = fbAuthManager
        
        return view
    }
    
}
