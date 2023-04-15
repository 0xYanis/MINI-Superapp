//
//  LoginInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func userWantLogin(_ email: String,_ password: String)
}

final class LoginInteractor: LoginInteractorProtocol {

    weak var presenter: LoginPresenterProtocol?
    var entity: LoginEntity?
    
    func userWantLogin(_ email: String,_ password: String) {
        if email == "123" && password == "123" {
            presenter?.loginIsCorrect()
        } else {
            presenter?.loginIsNotCorrect()
        }
    }
}
