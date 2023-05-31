//
//  LoginModuleTests.swift
//  LoginModuleTests
//
//  Created by Yan Rybkin on 31.05.2023.
//

import XCTest
@testable import MINI

import Lottie

final class LoginModuleTests: XCTestCase {
    
    var view: MockLoginView!
    var interactor: LoginInteractor!
    var router: MockLoginRouter!
    var presenter: LoginPresenter!
    var lottieService: MockLoginLottieService!
    var biometryService: MockBiometryService!
    
    override func setUpWithError() throws {
        view = MockLoginView()
        interactor = LoginInteractor()
        router = MockLoginRouter()
        presenter = LoginPresenter(interactor: interactor, router: router)
        lottieService = MockLoginLottieService()
        biometryService = MockBiometryService()
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        
        interactor.biometryService = biometryService
       //interactor.lottieService = lottieService
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        
        measure {
            
        }
    }

}
//MARK: - Mock objects
final class MockLoginView: LoginViewProtocol {
    var presenter: LoginPresenterProtocol?
    
    var lottieAnimation = LottieAnimationView()
    var alertTitle: String?
    var alertMessage: String?
    
    func setAnimation(lottie: LottieAnimation) {
        lottieAnimation.animation = lottie
    }
    func showAlert(_ title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
    }
    func loginIsNotCorrect() {}
}

final class MockLoginRouter: LoginRouterProtocol {
    func userDidLogin() {}
}

final class MockLoginLottieService: LoginLottieServiceProtocol {
    func loadAnimation(completion: @escaping handler) {
        
    }
}

final class MockBiometryService: BiometryServiceProtocol {
    func authWithBiometry(completion: @escaping (Bool, Error?) -> Void) {
        
    }
}
