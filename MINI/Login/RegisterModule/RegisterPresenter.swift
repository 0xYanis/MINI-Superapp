//
//  RegisterPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import Foundation

protocol RegisterPresenterProtocol: AnyObject {
    func userWantToLogin(login: String, password: String, repeatPassword: String)
    
    func registerIsCorrect()
    func registerIsNotCorrect(with message: String)
}

final class RegisterPresenter {
    
    weak var view: RegisterViewProtocol?
    var router: RegisterRouterProtocol
    var interactor: RegisterInteractorProtocol
    
    init(
        router: RegisterRouterProtocol,
        interactor: RegisterInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func userWantToLogin(login: String, password: String, repeatPassword: String) {
        interactor.userWantToLogin(login: login, password: password, repeatPassword: repeatPassword)
    }
    
    func registerIsCorrect() {
        router.userDidRegister()
    }
    
    func registerIsNotCorrect(with message: String) {
        view?.registerIsNotCorrect(with: message)
    }
    
    
}
