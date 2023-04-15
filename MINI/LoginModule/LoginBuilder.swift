//
//  LoginBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

final class LoginBuilder {
    static func build() -> UIViewController {
        let viewController = LoginViewController()
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(interactor: interactor, router: router)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
