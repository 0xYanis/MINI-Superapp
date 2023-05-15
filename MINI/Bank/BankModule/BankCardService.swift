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
    
    func getCardsData(completion: @escaping(Result<[BankCardEntity]?, Error>) -> Void) {
        let cardData = [
            BankCardEntity(id: 0, cardColor: "visa", logo: "visa", amount: "$512.5", number: "*3215"),
            BankCardEntity(id: 1, cardColor: "mir", logo: "mir", amount: "59,000.99", number: "*5672"),
            BankCardEntity(id: 2, cardColor: "mastercard", logo: "mastercard", amount: "$12.5", number: "*5621"),
            BankCardEntity(id: 3, cardColor: "american", logo: "american", amount: "$990.0", number: "*6432"),
            BankCardEntity(id: 4, cardColor: "mir", logo: "mir", amount: "29,000", number: "*2234")
        ]
        
        completion(.success(cardData))
    }
    
    
}
