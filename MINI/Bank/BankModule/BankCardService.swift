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
    private let cardUrl = "https://my-json-server.typicode.com/0xyanis/MINIapi/cards"
    
    init(
        apiService: APIServiceProtocol
    ) {
        self.apiService = apiService
    }
    
    func getCardsData(completion: @escaping(Result<[BankCardEntity]?, Error>) -> Void) {
        apiService.getRequest(url: cardUrl) { (result: Result<BankCardStruct, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.cardList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
