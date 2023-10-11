//
//  LoginPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation
import Lottie

protocol LoginPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func userWantRegister()
    
    func userDidTapLogin(name: String, password: String)
    func userDidTapBiometry()
    func loginIsCorrect()
    func loginIsNotCorrect()
}

final class LoginPresenter {
    
    weak var view: LoginViewProtocol?
    
    private var interactor: LoginInteractorProtocol
    private var router: LoginRouterProtocol
    
    init(
        interactor: LoginInteractorProtocol,
        router: LoginRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func userWantRegister() {
        router.goToRegisterView()
    }
    
    func userDidTapLogin(name: String, password: String) {
        interactor.userWantLogin(name, password)
    }
    
    func userDidTapBiometry() {
        interactor.userWantBiometry()
    }
    
    func loginIsCorrect() {
        DispatchQueue.main.async {
            self.router.userDidLogin()
        }
    }
    
    func loginIsNotCorrect() {
        view?.loginIsNotCorrect()
        DispatchQueue.main.async {
            self.view?.showAlert(
                "error_login_title".localized,
                message: "error_message_title".localized
            )
        }
    }
    
}
