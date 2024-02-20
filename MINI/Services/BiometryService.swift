//
//  BiometryService.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import LocalAuthentication

public protocol BiometryServiceProtocol: AnyObject {
    func authWithBiometry(completion: @escaping (Bool, Error?) -> Void)
}

public final class BiometryService: BiometryServiceProtocol {
    private let context = LAContext()
    
    private enum Consts: String {
        case reason = "Authenticate with Face ID"
    }
    
    public func authWithBiometry(completion: @escaping (Bool, Error?) -> Void) {
        let reason = Consts.reason.rawValue
        var error: NSError?
        
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) else { completion(false, error); return }
        
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason
        ) { success, error in
            completion(success, error as NSError?)
        }
    }
}
