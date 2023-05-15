//
//  BankInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func getCardData() -> [BankCardEntity]
}

final class BankInteractor: BankInteractorProtocol {
    
    weak var presenter: BankPresenterProtocol?
    
    func viewDidLoaded() {
        
    }
    
    func getCardData() -> [BankCardEntity] {
        var cardData = [BankCardEntity]()
        cardData.append(BankCardEntity(cardColor: "visa", logo: "visa", amount: "$512.5", number: "*3215"))
        cardData.append(BankCardEntity(cardColor: "mir", logo: "mir", amount: "59,000.99", number: "*5672"))
        cardData.append(BankCardEntity(cardColor: "mastercard", logo: "mastercard", amount: "$12.5", number: "*5621"))
        cardData.append(BankCardEntity(cardColor: "american", logo: "american", amount: "$990.0", number: "*6432"))
        cardData.append(BankCardEntity(cardColor: "mir", logo: "mir", amount: "29,000", number: "*2234"))
        return cardData
    }
}
