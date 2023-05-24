//
//  BankTransactionService.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

protocol BankTransactionServiceProtocol: AnyObject {
    func getTransactionsData(completion: @escaping(Result<[BankTransactionEntity]?, Error>) -> Void)
}

final class BankTransactionService: BankTransactionServiceProtocol {
    
    var apiService: APIServiceProtocol
    private let cardUrl = "http://localhost:3001/transactions"
    
    init(
        apiService: APIServiceProtocol
    ) {
        self.apiService = apiService
    }
    
    func getTransactionsData(completion: @escaping(Result<[BankTransactionEntity]?, Error>) -> Void) {
        apiService.getRequest(url: cardUrl) { (result: Result<BankTransactionStruct, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.transactionList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
