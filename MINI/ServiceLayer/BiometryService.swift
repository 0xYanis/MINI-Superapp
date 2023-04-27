//
//  BiometryService.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation
import LocalAuthentication

protocol BiometryServiceProtocol: AnyObject {
    func authWithBiometry(completion: @escaping (Bool, Error?) -> Void)
}

class BiometryService: BiometryServiceProtocol {
    
    private let context = LAContext()
    
    func authWithFaceID(completion: @escaping (Bool, Error?) -> Void) {
        
        let reason = "Аутентификация с помощью Face ID"
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            completion(false, error)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: reason) { success, error in
            completion(success, error as NSError?)
        }
    }
}
