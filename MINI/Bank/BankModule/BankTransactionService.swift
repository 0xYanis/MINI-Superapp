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
    private let cardUrl = "https://my-json-server.typicode.com/0xyanis/MINIapi/transactions"
    private let cache = NSCache<NSString, BankTransactionObject>()
    
    init(
        apiService: APIServiceProtocol = APIService()
    ) {
        self.apiService = apiService
    }
    
    func getTransactionsData(completion: @escaping(Result<[BankTransactionEntity]?, Error>) -> Void) {
        if let cacheData = cache.object(forKey: "BankTransactionObject") {
            completion(.success(cacheData.transactionList))
        } else {
            apiService.getRequest(url: cardUrl) { (result: Result<BankTransactionObject, Error>) in
                switch result {
                case .success(let data):
                    self.cache.setObject(data, forKey: "BankTransactionObject")
                    completion(.success(data.transactionList))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    
}
