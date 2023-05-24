//
//  BankCardService.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

protocol BankCardServiceProtocol: AnyObject {
    func getCardsData(completion: @escaping(Result<[BankCardEntity]?, Error>) -> Void)
}

final class BankCardService: BankCardServiceProtocol {
    
    var apiService: APIServiceProtocol
    private let cardUrl = "http://localhost:3001/cards"
    
    init(
        apiService: APIServiceProtocol
    ) {
        self.apiService = apiService
    }
    
    func getCardsData(completion: @escaping(Result<[BankCardEntity]?, Error>) -> Void) {
//        apiService.getRequest(url: cardUrl) { (result: Result<BankCardEntity, Error>) in
//
//        }
    }
    
    
}
