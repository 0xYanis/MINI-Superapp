//
//  LoginPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func userDidTapLogin(email: String, password: String)
    func loginIsCorrect()
    func loginIsNotCorrect()
}

final class LoginPresenter {
    
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol
    var router: LoginRouterProtocol
    
    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func userDidTapLogin(email: String, password: String) {
        interactor.userWantLogin(email, password)
    }
    func loginIsCorrect() {
        DispatchQueue.main.async {
            self.router.userDidLogin()
        }
    }
    func loginIsNotCorrect() {
        DispatchQueue.main.async {
            self.view?.showAlert(message: "Неверный логин")
        }
    }
}
