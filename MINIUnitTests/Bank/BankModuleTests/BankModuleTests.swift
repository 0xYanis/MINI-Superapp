//
//  BankModuleTests.swift
//  BankModuleTests
//
//  Created by Yan Rybkin on 31.05.2023.
//

import XCTest
@testable import MINI

final class BankModuleTests: XCTestCase {
    
    private var view: MockView!
    private var router: BankRouter!
    private var presenter: BankPresenter!
    private var interactor: BankInteractor!
    
    private var cardData: [Card] = []
    private var tempData: [Template] = []
    private var tranData: [Transaction] = []
    
    override func setUpWithError() throws {
        router = BankRouter()
        interactor = BankInteractor()
        presenter = BankPresenter(router: router, interactor: interactor)
        view = MockView(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
    }
    
    func testMock() throws {
        
    }
    
}

final class MockView: BankViewProtocol {
    
    private var presenter: BankPresenterProtocol
    
    init(presenter: BankPresenterProtocol) {
        self.presenter = presenter
        presenter.viewDidLoaded()
    }
    
    func updateBankTable() {
        
    }
    
    func updateHistory() {
        
    }
    
    func loadingDataGetFailed(with error: String) {
        
    }
}
