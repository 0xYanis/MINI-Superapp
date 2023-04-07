//
//  LoginInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 07.04.2023.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func willLogin()
}

class LoginInteractor: LoginInteractorProtocol {
    
    weak var presenter: LoginPresenterProtocol?
    
    func willLogin() {
        ///
    }
}
