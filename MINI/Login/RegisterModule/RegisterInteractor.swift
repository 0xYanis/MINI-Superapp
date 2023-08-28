//
//  RegisterInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import Foundation

protocol RegisterInteractorProtocol: AnyObject {
    func userWantToLogin(login: String, password: String, repeatPassword: String)
}

final class RegisterInteractor: RegisterInteractorProtocol {
    
    weak var presenter: RegisterPresenterProtocol?
    var keychainService: KeyChainServiceProtocol?
    var fbAuthManager: FBAuthProtocol?
    
    func userWantToLogin(login: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.passwordsDoNotMatch.rawValue
            )
            return
        }
        
        if isNotValid(login) {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.invalidLogin.rawValue
            )
            return
        }
        
        if isNotValid(password) {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.weakPassword.rawValue
            )
            return
        }
        
        fbAuthManager?.signUp(email: login, password: password) { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                self.presenter?.registerIsNotCorrect(with: error.localizedDescription)
            }
            guard let _ = user else { return }
            self.presenter?.registerIsCorrect()
        }
    }
    
}

private extension RegisterInteractor {
    
    enum ErrorMessages: String {
        case invalidLogin = "Неверный формат ввода"
        case weakPassword = "Слабый пароль"
        case passwordsDoNotMatch = "Пароли не совпадают"
        case loginAlreadyRegistered = "Аккаунт уже зарегистрирован"
    }
    
    func isNotValid(_ string: String) -> Bool {
        let stringLengthRange = 5...25
        guard !string.isEmpty,
              stringLengthRange.contains(string.count),
              !string.contains(" ") else {
            return true
        }
        return false
    }
    
    
}
