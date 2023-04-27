//
//  LoginInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func userWantLogin(_ name: String,_ password: String)
    func userWantBiometry()
}

final class LoginInteractor: LoginInteractorProtocol {

    weak var presenter: LoginPresenterProtocol?
    var entity: LoginEntity?
    var biometryService: BiometryServiceProtocol?
    
    func userWantLogin(_ name: String,_ password: String) {
        // TODO: Выполнить запрос на сервер для аутентификации и получить токен аутентификации
        if name == "123" && password == "123" {
            
            let authToken = "YourAuthToken" // Временный токен
            saveAuthToken(authToken: authToken)
            
            presenter?.loginIsCorrect()
        } else {
            presenter?.loginIsNotCorrect()
        }
    }

    func userWantBiometry() {
        biometryService?.authWithBiometry(completion: { [weak self] result, _ in
            if result {
                let authToken = "YourAuthToken" // Временный токен
                self?.saveAuthToken(authToken: authToken)
                self?.presenter?.loginIsCorrect()
            }
        })
    }
    
    private func saveAuthToken(authToken: String) {
        UserDefaults.standard.set(authToken, forKey: "authToken")
    }
}
