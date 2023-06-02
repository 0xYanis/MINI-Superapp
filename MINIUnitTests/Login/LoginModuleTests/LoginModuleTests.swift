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
    var router: LoginRouter!
    var presenter: LoginPresenter!
    var lottieService: MockLoginLottieService!
    var biometryService: MockBiometryService!
    
    //MARK: - Initial setup
    override func setUpWithError() throws {
        view = MockLoginView()
        router = LoginRouter()
        lottieService = MockLoginLottieService()
        biometryService = MockBiometryService()
        interactor = LoginInteractor()
        presenter = LoginPresenter(interactor: interactor, router: router)
        
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        
        interactor.biometryService = biometryService
        interactor.lottieService = lottieService
    }
    
    override func tearDownWithError() throws {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
        lottieService = nil
        biometryService = nil
    }
    
    //MARK: - Tests
    //MARK: Login
    func testInteractorCorrectLogin() throws {
        let name = "admin"
        let password = "admin"
        
        interactor.userWantLogin(name, password)
        
        
    }
    
    func testInteractorEmptyDataLogin() throws {
        let name = ""
        let password = ""
        
        interactor.userWantLogin(name, password)
        
        XCTAssertTrue(view.loginIsNotCorrectCall)
    }
    
    //MARK: Biometry service
    func testInteractorSuccessfulBiometry() throws {
        biometryService.result = true
        
        interactor.userWantBiometry()
        
        XCTAssertFalse(view.loginIsNotCorrectCall)
    }
    
    func testInteractorFailedBiometry() throws {
        let result = false
        biometryService.result = result
        
        interactor.userWantBiometry()
        
        XCTAssertEqual(result, view.loginIsNotCorrectCall)
    }
    
    //MARK: Lottie service
    func testInteractorFailedLoadLottie() throws {
        let error = MockError.loadingGetFailed
        lottieService.result = .failure(error)
        
        presenter.viewDidLoaded()
        // -> interactor.viewDidLoaded() -> lottieService.getAnimation
        
        XCTAssertNil(view.lottieAnimation)
    }
    
    func testInteractorNoneLoadLottie() throws {
        lottieService.result = .none
        
        presenter.viewDidLoaded()
        // -> interactor.viewDidLoaded() -> lottieService.getAnimation
        
        XCTAssertNil(view.lottieAnimation)
    }
    
    //    func testPerformanceExample() throws {
    //
    //        measure {
    //
    //        }
    //    }
}
//MARK: Mock objects
//MARK: - MockLoginView
final class MockLoginView: LoginViewProtocol {
    var presenter: LoginPresenterProtocol?
    
    var loginIsNotCorrectCall = false
    
    var lottieAnimation: LottieAnimation?
    var alertTitle: String?
    var alertMessage: String?
    
    func setAnimation(lottie: LottieAnimation) {
        self.lottieAnimation = lottie
    }
    func showAlert(_ title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
    }
    func loginIsNotCorrect() {
        loginIsNotCorrectCall = true
    }
}

//MARK: - MockLoginLottieService
final class MockLoginLottieService: LoginLottieServiceProtocol {
    typealias handler = (_ animation: Result<LottieAnimation, Error>?) -> Void
    
    var result: Result<LottieAnimation, Error>?
    
    func loadAnimation(completion: @escaping handler) {
        completion(result)
    }
}

//MARK: - MockBiometryService
final class MockBiometryService: BiometryServiceProtocol {
    
    var result: Bool!
    
    func authWithBiometry(completion: @escaping (Bool, Error?) -> Void) {
        completion(result, nil)
    }
}

enum MockError: Error {
    case loadingGetFailed
}
