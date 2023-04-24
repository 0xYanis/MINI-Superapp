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
            
            let authToken = "YourAuthToken"
            UserDefaults.standard.set(authToken, forKey: "authToken")
            
            presenter?.loginIsCorrect()
        } else {
            presenter?.loginIsNotCorrect()
        }
    }

    func userWantBiometry() {
        biometryService?.authWithFaceID(completion: { [weak self] result, _ in
            if result {
                self?.presenter?.loginIsCorrect()
            }
        })
    }
}
