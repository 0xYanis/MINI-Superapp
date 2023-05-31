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
    var presenter: MockLoginPresenter!
    var lottieService: MockLoginLottieService!
    var biometryService: MockBiometryService!
    
    //MARK: - Initial setup
    override func setUpWithError() throws {
        view = MockLoginView()
        router = LoginRouter()
        presenter = MockLoginPresenter()
        lottieService = MockLoginLottieService()
        biometryService = MockBiometryService()
        
        interactor = LoginInteractor()
        
        presenter.router = router
        presenter.interactor = interactor
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
        let name = "123"
        let password = "123"
        
        interactor.userWantLogin(name, password)
        
        XCTAssertTrue(presenter.loginIsCorrectCalled)
    }
    
    func testInteractorEmptyDataLogin() throws {
        let name = ""
        let password = ""
        
        interactor.userWantLogin(name, password)
        
        XCTAssertFalse(presenter.loginIsNotCorrectCalled)
    }
    
    //MARK: Biometry service
    func testInteractorSuccessfulBiometry() throws {
        biometryService.result = true
        
        interactor.userWantBiometry()
        
        XCTAssertTrue(presenter.loginIsCorrectCalled)
    }
    
    func testInteractorFailedBiometry() throws {
        biometryService.result = false
        
        interactor.userWantBiometry()
        
        XCTAssertFalse(presenter.loginIsNotCorrectCalled)
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
    
    func testRouterSuccessLogin() throws {
        
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
    func loginIsNotCorrect() {}
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

//MARK: - MockLoginPresenter
final class MockLoginPresenter: LoginPresenterProtocol {
    
    weak var view: MockLoginView?
    var router: LoginRouterProtocol?
    var interactor: LoginInteractorProtocol?
    
    var loginIsCorrectCalled = false
    var loginIsNotCorrectCalled = false
    
    func viewDidLoaded() {
        interactor?.viewDidLoaded()
    }
    
    func loadAnimation(_ data: LottieAnimation) {
        view?.setAnimation(lottie: data)
    }
    
    func userDidTapLogin(name: String, password: String) {
        interactor?.userWantLogin(name, password)
    }
    
    func userDidTapBiometry() {
        interactor?.userWantBiometry()
    }
    
    func loginIsCorrect() {
        loginIsCorrectCalled = true
        router?.userDidLogin()
    }
    
    func loginIsNotCorrect() {
        loginIsNotCorrectCalled = false
    }
}

enum MockError: Error {
    case loadingGetFailed
}
