//
//  AuthAssembly.swift
//  MINI
//
//  Created by Yan Rybkin on 08.04.2023.
//

import UIKit

class AuthAssembly {
    static func authBiuld() -> UIViewController {
        let viewController = AuthViewController()
        let interactor = AuthInteractor()
        let router = AuthRouter()
        let presenter = AuthPresenter(interactor: interactor, router: router)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
