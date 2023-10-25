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
    
    weak private var view: UIViewController?
    weak private var coordinator: LoginCoordinator?
    
    init(view: UIViewController, coordinator: LoginCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func userDidLogin() {
        coordinator?.finish()
    }
    
    func goToRegisterView() {
        coordinator?.goToRegistrate()
    }
    
}
