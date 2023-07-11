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
    
    func userWantLogin(_ name: String, _ password: String) {
        guard let storedPassword = keychainService?.getValue(forKey: name),
                storedPassword == password else {
            presenter?.loginIsNotCorrect()
            return
        }
        
        saveAuthToken(with: name)
        presenter?.loginIsCorrect()
    }
    
    //MARK: - Для дебага вход по faceID
    func userWantBiometry() {
        biometryService?.authWithBiometry(completion: { [weak self] result, _ in
            if result {
                let authToken = "YourAuthToken" // Временный токен
                self?.saveAuthToken(with: authToken)
                self?.presenter?.loginIsCorrect()
            }
        })
    }
    
}

private extension LoginInteractor {
    func saveAuthToken(with name: String) {
        UserDefaults.standard.set(
            name,
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
