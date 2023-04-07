//
//  LoginPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 07.04.2023.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    
}

class LoginPresenter {
    weak var view: LoginViewControllerProtocol?
    var router: LoginRouterProtocol
    var interactor: LoginInteractorProtocol
    
    init(router: LoginRouterProtocol, interactor: LoginInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
}
