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
        guard isValidString(name), isValidString(password) else {
            presenter?.loginIsNotCorrect()
            return
        }
        
        guard let storedPassword = keychainService?.getValue(forKey: name),
                storedPassword == password else {
            presenter?.loginIsNotCorrect()
            return
        }
        
        saveAuthToken(authToken: "YourAuthToken")
        presenter?.loginIsCorrect()
    }
    
    //MARK: - Для дебага вход по faceID
    func userWantBiometry() {
        biometryService?.authWithBiometry(completion: { [weak self] result, _ in
            if result {
                let authToken = "YourAuthToken" // Временный токен
                self?.saveAuthToken(authToken: authToken)
                self?.presenter?.loginIsCorrect()
            }
        })
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
    
    func isValidString(_ string: String) -> Bool {
        let stringLengthRange = 8...25
        guard !string.isEmpty,
              stringLengthRange.contains(string.count),
              !string.contains(" "),
              string.isAlphanumeric else {
            return false
        }
        return true
    }
}
