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
            BankCardEntity(id: 0, cardColor: "visa", logo: "visa", cardType: "Classic", amount: 89.50, number: "*1234", bankName: "Mono", holderName: "Bob", expirationDate: "22.02.2025", cvv: "123"),
            BankCardEntity(id: 1, cardColor: "mastercard", logo: "mastercard", cardType: "Gold", amount: 120.00, number: "*5678", bankName: "Privat", holderName: "Alice", expirationDate: "06.03.2024", cvv: "456"),
            BankCardEntity(id: 2, cardColor: "american", logo: "american", cardType: "Platinum", amount: 1050.00, number: "*9012", bankName: "OTP", holderName: "Charlie", expirationDate: "11.07.2023", cvv: "789")
        ]
        
        completion(.success(cardData))
    }
    
    
}
