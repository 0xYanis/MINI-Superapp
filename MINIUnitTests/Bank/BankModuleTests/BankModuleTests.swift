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
        realmService = nil
        mockCardService = nil
        mockTemplateService = nil
        mockTransactionService = nil
        
        view = nil
        router = nil
        interactor = nil
        presenter = nil
    }
    
    func testLoadDataToViewSuccessful() throws {
        // given
        let card: [BankCardEntity] = []
        let template: [BankTemplateEntity] = []
        let transaction: [BankTransactionEntity] = []
        mockCardService.result = .success(card)
        mockTemplateService.result = .success(template)
        mockTransactionService.result = .success(transaction)
        let didTableUpdateExpectation = expectation(description: "didTableUpdate")
        let didHistoryUpdateExpectation = expectation(description: "didHistoryUpdate")
        
        // when
        view.viewDidLoad()
        
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.view.didTableUpdate)
            didTableUpdateExpectation.fulfill()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.view.didHistoryUpdate)
            didHistoryUpdateExpectation.fulfill()
        }
        
        wait(for: [didTableUpdateExpectation, didHistoryUpdateExpectation], timeout: 5)
    }
    
    func testLoadDataToViewFailed() throws {
        // given
        let error = MockError.loadingGetFailed
        mockCardService.result = .failure(error)
        mockTemplateService.result = .failure(error)
        mockTransactionService.result = .failure(error)
        
        // when
        view.viewDidLoad()
        
        // then
        XCTAssertFalse(view.didTableUpdate)
        XCTAssertFalse(view.didHistoryUpdate)
    }
    
    func testInteractorGetFilteredData() throws {
        // given
        let name = "Baz"
        let mockData = [BankTransactionEntity(id: 0, icon: "", name: name, date: "", cost: 0, cardNumber: 0, location: "", currency: "", status: "", category: "", notes: "", merchantID: 0, customerID: 0)]
        interactor.transactionsData = mockData
        let searchText = "Baz"
        
        // when
        presenter.searchBarTextDidChange(with: searchText)
        let result = presenter.getFilteredData()
        
        // then
        XCTAssertEqual(result, mockData)
    }
    
    func testInteractorGetEmptyFilteredData() throws {
        // given
        let searchText = ""
        let mockData: [BankTransactionEntity] = []
        
        // when
        presenter.searchBarTextDidChange(with: "")
        let result = presenter.getFilteredData()
        
        // then
        XCTAssertEqual(result, mockData)
    }
    
    func testInteractorUserTapSeeAll() throws {
        // given
        let mockData = [
            BankTemplateEntity(id: 0, image: "", label: ""),
            BankTemplateEntity(id: 1, image: "", label: "")
        ]
        interactor.templatesData = mockData
        
        // when
        presenter.userDidTapSeeAll()
        let result = interactor.userDidTapSeeAll()
        
        // then
        XCTAssertEqual(result, mockData)
    }
    
    func testInteractorUserTapDetailCard() throws {
        // given
        let mockData = [
        BankCardEntity(id: 0, cardColor: "", logo: "", cardType: "", amount: 0, currency: "", number: "", bankName: "", holderName: "", expirationDate: "", cvv: "")
        ]
        interactor.cardsData = mockData
        
        // when
        presenter.userDidTapCard(index: 0)
        let result = interactor.userDidTapCard(index: 0)
        
        // then
        XCTAssertEqual(mockData[0], result)
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
    
    func viewDidLoad() {
        presenter?.viewDidLoaded()
    }
    
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

enum MockError: String, Error {
    case loadingGetFailed = "loadingGetFailed"
}
