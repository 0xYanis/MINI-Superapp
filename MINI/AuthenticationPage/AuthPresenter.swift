//
//  AuthPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 08.04.2023.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    
}

class AuthPresenter {
    weak var view: AuthViewControllerProtocol?
    var interactor: AuthInteractorProtocol
    var router: AuthRouterProtocol
    
    init(interactor: AuthInteractorProtocol, router: AuthRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension AuthPresenter: AuthPresenterProtocol {
    
}
