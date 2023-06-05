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
    var lottieService: LoginLottieServiceProtocol?
    
    func viewDidLoaded() {
        getLottieAnimation()
    }
    
    func userWantLogin(_ name: String,_ password: String) {
        if keychainService?.getValue(forKey: name) == password {
            let authToken = "YourAuthToken" // Временный токен
            saveAuthToken(authToken: authToken)
            
            presenter?.loginIsCorrect()
        } else {
            presenter?.loginIsNotCorrect()
        }
    }

    func userWantBiometry() {
//        biometryService?.authWithBiometry(completion: { [weak self] result, _ in
//            if result {
//                let authToken = "YourAuthToken" // Временный токен
//                self?.saveAuthToken(authToken: authToken)
//                self?.presenter?.loginIsCorrect()
//            }
//        })
    }
}

private extension LoginInteractor {
    private func saveAuthToken(authToken: String) {
        UserDefaults.standard.set(
            authToken,
            forKey: "authToken"
        )
    }
    
    func getLottieAnimation() {
        lottieService?.loadAnimation(completion: { [weak self] animation in
            switch animation {
            case .success(let data):
                self?.presenter?.loadAnimation(data)
            case .failure:
                return
            case .none:
                return
            }
        })
    }
}
