//
//  LoginPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 07.04.2023.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func didTapLock()
    func didTapAccount()
    func didTapLogin()
}

class LoginPresenter {
    weak var view: LoginViewControllerProtocol?
    var router: LoginRouterProtocol
    var interactor: LoginInteractorProtocol
    
    var isSecureField = false
    var isHidden = false
    
    init(router: LoginRouterProtocol, interactor: LoginInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func didTapLock() {
        view?.isNotSecureField(secure: isSecureField)
        isSecureField = !isSecureField
    }
    
    func didTapAccount() {
        view?.resizeLoginView(resize: isHidden)
        isHidden = !isHidden
    }
    
    func didTapLogin() {
        interactor.willGoNextView()
    }
}
