//
//  LoginEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

final class LoginEntity {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
