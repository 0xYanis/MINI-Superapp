//
//  BankModuleTests.swift
//  BankModuleTests
//
//  Created by Yan Rybkin on 31.05.2023.
//

import XCTest
@testable import MINI

final class BankModuleTests: XCTestCase {
    
    var view: MockBankView?
    var router: BankRouter?
    var presenter: BankPresenter?
    var interactor: BankInteractor?
    
    var cardData: [Card] = []
    var tempData: [Template] = []
    var tranData: [Transaction] = []
    
    override func setUpWithError() throws {
        view = MockBankView()
        router = BankRouter()
        interactor = BankInteractor()
        presenter = BankPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        view        = nil
        router      = nil
        interactor  = nil
        presenter   = nil
        
        cardData    = []
        tempData    = []
        tranData    = []
    }
    
    func testMock() throws {
        
    }
    
}
