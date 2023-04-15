//
//  LoginInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func userWantLogin(_ email: String,_ password: String)
    func userWantBiometry()
}

final class LoginInteractor: LoginInteractorProtocol {

    weak var presenter: LoginPresenterProtocol?
    var entity: LoginEntity?
    var biometryService: BiometryServiceProtocol?
    
    func userWantLogin(_ email: String,_ password: String) {
        if email == "123" && password == "123" {
            presenter?.loginIsCorrect()
        } else {
            presenter?.loginIsNotCorrect()
        }
    }
    func userWantBiometry() {
        biometryService?.authWithFaceID(completion: { [weak self] result, error in
            if let _ = error {
                self?.presenter?.loginIsNotCorrect()
            }
            switch result {
            case true:
                self?.presenter?.loginIsCorrect()
            case false:
                self?.presenter?.loginIsNotCorrect()
            }
        })
    }
}
