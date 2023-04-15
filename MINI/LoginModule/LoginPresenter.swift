//
//  LoginPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func userDidTapLogin(name: String, password: String)
    func userDidTapBiometry()
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
        DispatchQueue.main.async {
            self.view?.showAlert("Ошибка", message: "Неверный логин")
        }
    }
}
