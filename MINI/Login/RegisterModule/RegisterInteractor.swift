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
    var fbFirestoreManager: FBFirestoreProtocol?
    
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
        
        DispatchQueue.global().async {
            self.fbAuthManager?.signUp(
                email: login,
                password: password
            ) { [weak self] user, error in
                guard let self = self else { return }
                if let error = error {
                    let message = error.localizedDescription
                    self.presenter?.registerIsNotCorrect(with: message)
                }
                
                guard let user = user else { return }
                self.fbFirestoreManager?.setUserData(user: user)
                self.saveUserUID(user.uid)
                self.presenter?.registerIsCorrect()
            }
        }
    }
    
}

private extension RegisterInteractor {
    
    func saveUserUID(_ uid: String) {
        UserDefaults.standard.set(uid, forKey: "uid")
        UserDefaults.standard.synchronize()
    }
    
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
