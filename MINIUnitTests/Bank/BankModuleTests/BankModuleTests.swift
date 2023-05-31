//
//  BankModuleTests.swift
//  BankModuleTests
//
//  Created by Yan Rybkin on 31.05.2023.
//

import XCTest
@testable import MINI

final class BankModuleTests: XCTestCase {

    var view: MockBankView!
    var router: BankRouter!
    var presenter: BankPresenter!
    var interactor: BankInteractor!
    
    var realmService: RealmService!
    var mockCardService: MockCardService!
    var mockTemplateService: MockTemplateService!
    var mockTransactionService: MockTransactionService!
    
    override func setUpWithError() throws {
        realmService = RealmService()
        mockCardService = MockCardService()
        mockTemplateService = MockTemplateService()
        mockTransactionService = MockTransactionService()
        
        view = MockBankView()
        router = BankRouter()
        interactor = BankInteractor(
            realmService: realmService,
            cardService: mockCardService,
            templateService: mockTemplateService,
            transactionService: mockTransactionService
        )
        presenter = BankPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        
    }

    
    
//    func testPerformanceExample() throws {
//
//        measure {
//
//        }
//    }
}

final class MockBankView: BankViewProtocol {
    
    var presenter: BankPresenterProtocol?
    
    var didTableUpdate = false
    var didHistoryUpdate = false
    
    func updateBankTable() {
        didTableUpdate = true
    }
    
    func updateHistory() {
        didHistoryUpdate = true
    }
}

final class MockCardService: BankCardServiceProtocol {
    
    var result: Result<[BankCardEntity]?, Error>!
    
    func getCardsData(completion: @escaping (Result<[BankCardEntity]?, Error>) -> Void) {
        completion(result)
    }
}

final class MockTemplateService: BankTemplateServiceProtocol {
    
    var result: Result<[BankTemplateEntity]?, Error>!
    
    func getTemplatesData(completion: @escaping (Result<[BankTemplateEntity]?, Error>) -> Void) {
        completion(result)
    }
}

final class MockTransactionService: BankTransactionServiceProtocol {
    
    var result: Result<[BankTransactionEntity]?, Error>!
    
    func getTransactionsData(completion: @escaping (Result<[BankTransactionEntity]?, Error>) -> Void) {
        completion(result)
    }
}
