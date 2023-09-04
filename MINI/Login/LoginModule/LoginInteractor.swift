//
//  LoginInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func userWantLogin(_ name: String,_ password: String)
    func userWantBiometry()
}

final class LoginInteractor: LoginInteractorProtocol {
    
    weak var presenter: LoginPresenterProtocol?
    var keychainService: KeyChainServiceProtocol?
    var biometryService: BiometryServiceProtocol?
    var fbAuthManager: FBAuthProtocol?
    
    func viewDidLoaded() {
        
    }
    
    func userWantLogin(_ name: String, _ password: String) {
        fbAuthManager?.signIn(email: name, password: password) { [weak self] user, error in
            guard let self = self else { return }
            if let _ = error {
                self.presenter?.loginIsNotCorrect()
                return
            }
            if let user = user {
                self.saveUserUID(user.uid)
                self.presenter?.loginIsCorrect()
            }
        }
    }
    
    func userWantBiometry() {
        biometryService?.authWithBiometry { [weak self] result, _ in
            guard let self = self else { return }
            guard let _ = self.fbAuthManager?.currentUser else { return }
            if result == true { self.presenter?.loginIsCorrect() }
        }
    }
    
    private func saveUserUID(_ uid: String) {
        UserDefaults.standard.set(uid, forKey: "uid")
    }
    
}
