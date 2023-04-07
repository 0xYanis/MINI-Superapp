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
    
    private var isSecureField = false
    
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
        
    }
    
    func didTapLogin() {
        interactor.willLogin()
    }
}
