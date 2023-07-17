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
    
    var cardService: MockCardService!
    var tempService: MockTemplateService!
    var tranService: MockTransactionService!
    
    var cardData: [BankCardEntity] = []
    var tempData: [BankTemplateEntity] = []
    var tranData: [BankTransactionEntity] = []
    
    override func setUpWithError() throws {
        cardService = MockCardService()
        tempService = MockTemplateService()
        tranService = MockTransactionService()
        
        view = MockBankView()
        router = BankRouter()
        interactor = BankInteractor(
            cardService: cardService,
            templateService: tempService,
            transactionService: tranService
        )
        presenter = BankPresenter(
            router: router,
            interactor: interactor
        )
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        
        cardData = [
            .init(id: 0, cardColor: "", logo: "", cardType: "",
                  amount: 0.0, currency: "", number: "",
                  bankName: "", expirationDate: "", cvv: "")
        ]
        tempData = [
            .init(id: 0, image: "", label: "")
        ]
        tranData = [
            .init(id: 0, name: "", date: "", cost: 0.0,
                  cardNumber: 0, currency: "", status: "",
                  notes: "", merchantID: 0, customerID: 0)
        ]
        
    }
    
    override func tearDownWithError() throws {
        cardService = nil
        tempService = nil
        tranService = nil
        
        view        = nil
        router      = nil
        interactor  = nil
        presenter   = nil
        
        cardData    = []
        tempData    = []
        tranData    = []
    }
    
    func testFetchDataSuccessful() throws {
        // given
        cardService.result = .success(cardData)
        tempService.result = .success(tempData)
        tranService.result = .success(tranData)
        
        // when
        view.viewDidLoad()
        
        // then
        XCTAssertEqual(cardData.first!.id, presenter.getCardData().first!.id, "❌")
        XCTAssertEqual(tempData.first!.id, presenter.getTemplateData().first!.id, "❌")
        XCTAssertEqual(tranData.first!.id, presenter.getTransactionData().first!.id, "❌")
    }
    
    func testFetchDataFailed() throws {
        // given
        enum ErrorType: Error { case failed }
        cardService.result = .failure(ErrorType.failed)
        tempService.result = .failure(ErrorType.failed)
        tranService.result = .failure(ErrorType.failed)
        
        // when
        view.viewDidLoad()
        
        // then
        XCTAssertEqual(ErrorType.failed.localizedDescription, view.error)
    }
    
}

final class MockBankView: BankViewProtocol {
    
    var presenter: BankPresenterProtocol?
    
    var error: String = ""
    
    func viewDidLoad() {
        presenter?.viewDidLoaded()
    }
    
    func updateBankTable() {
        
    }
    
    func updateHistory() {
        
    }
    
    func loadingDataGetFailed(with error: String) {
        self.error = error
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
