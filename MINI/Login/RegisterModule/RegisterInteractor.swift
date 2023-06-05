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
    
    
    func userWantToLogin(login: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.passwordsDoNotMatch.rawValue
            )
            return
        }
        
        if !isValidString(login) {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.invalidLogin.rawValue
            )
            return
        }
        
        if !isValidString(password) {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.weakPassword.rawValue
            )
            return
        }
        
        guard keychainService?.getValue(forKey: login) == nil else {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.loginAlreadyRegistered.rawValue
            )
            return
        }
        
        keychainService?.setValue(password, forKey: login)
        presenter?.registerIsCorrect()
    }
    
}

private extension RegisterInteractor {
    enum ErrorMessages: String {
        case invalidLogin = "Неверный формат ввода"
        case weakPassword = "Слабый пароль"
        case passwordsDoNotMatch = "Пароли не совпадают"
        case loginAlreadyRegistered = "Аккаунт уже зарегистрирован"
    }
    
    func isValidString(_ string: String) -> Bool {
        let stringLengthRange = 8...25
        guard !string.isEmpty,
              stringLengthRange.contains(string.count),
              !string.contains(" "),
              string.isAlphanumeric else {
            return false
        }
        return true
    }
}
