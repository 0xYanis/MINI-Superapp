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
    
    private var fbAuthManager: FBAuthProtocol!
    
    func viewDidLoaded() {
        fbAuthManager = FBAuthManager()
    }
    
    func userWantLogin(_ name: String, _ password: String) {
        fbAuthManager.signIn(email: name, password: password) { [weak self] user, error in
            guard let self = self else { return }
            if let _ = error {
                self.presenter?.loginIsNotCorrect()
                return
            }
            if let _ = user {
                self.presenter?.loginIsCorrect()
            }
        }
    }
    
    func userWantBiometry() {
        biometryService?.authWithBiometry { [weak self] result, _ in
            //guard let self = self else { return }
            
        }
    }
    
}
