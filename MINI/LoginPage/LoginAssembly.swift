//
//  LoginAssembly.swift
//  MINI
//
//  Created by Yan Rybkin on 07.04.2023.
//

import UIKit

class LoginAssembly {
    static func loginBuld() -> UIViewController {
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter(router: router, interactor: interactor)
        let viewController = LoginViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
