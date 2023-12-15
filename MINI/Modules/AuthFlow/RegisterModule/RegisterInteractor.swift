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
    
    // MARK: - Public properties
    
    weak var presenter: RegisterPresenterProtocol?
    
    // MARK: - Private properties
    
    private var keychainService: KeyChainServiceProtocol
    private var fbAuthManager: FBAuthProtocol
    private var fbFirestoreManager: FBFirestoreProtocol
    
    // MARK: - Lifecycle
    
    init(
        keychain: KeyChainServiceProtocol,
        authManager: FBAuthProtocol,
        firestore: FBFirestoreProtocol
    ) {
        self.keychainService = keychain
        self.fbAuthManager = authManager
        self.fbFirestoreManager = firestore
    }
    
    // MARK: - Public methods
    
    func userWantToLogin(login: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.passwordsDoNotMatch.rawValue)
            return
        }
        if isNotValid(login) {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.invalidLogin.rawValue)
            return
        }
        if isNotValid(password) {
            presenter?.registerIsNotCorrect(
                with: ErrorMessages.weakPassword.rawValue)
            return
        }
        signUp(login: login, password: password)
    }
    
}

// MARK: - Private methods

private extension RegisterInteractor {
    
    enum ErrorMessages: String {
        case invalidLogin = "Неверный формат ввода"
        case weakPassword = "Слабый пароль"
        case passwordsDoNotMatch = "Пароли не совпадают"
        case loginAlreadyRegistered = "Аккаунт уже зарегистрирован"
    }
    
    func saveUserUID(_ uid: String) {
        UserDefaults.standard.set(uid, forKey: "uid")
        UserDefaults.standard.synchronize()
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
    
    func signUp(login: String, password: String) {
        DispatchQueue.global().async {
            self.fbAuthManager.signUp(
                email: login,
                password: password
            ) { [weak self] user, error in
                guard let self = self else { return }
                if let error = error {
                    let message = error.localizedDescription
                    self.presenter?.registerIsNotCorrect(with: message)
                }
                guard let user = user else { return }
                self.fbFirestoreManager.setUserData(user: user)
                self.saveUserUID(user.uid)
                self.presenter?.registerIsCorrect()
            }
        }
    }
    
}
