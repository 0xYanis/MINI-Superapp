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
        let biometryService = BiometryService()
        let apiService = APIService()
        let lottieService = LoginLottieService(apiService: apiService)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.biometryService = biometryService
        interactor.lottieService = lottieService
        router.view = viewController
        
        return viewController
    }
    
}
