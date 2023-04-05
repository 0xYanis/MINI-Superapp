//
//  LoginPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 06.04.2023.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func didTapLock()
    func didTapAccount()
    func didTapLogin()
}

class LoginPresenter: LoginViewDelegate {
    
    let view: LoginView

    init(view: LoginView) {
        self.view = view
        self.view.delegate = self
    }
    
    func didTapLock() {
        print("lock")
    }
    
    func didTapAccount() {
        print("account")
    }
    
    func didTapLogin() {
        print("login")
    }
}
