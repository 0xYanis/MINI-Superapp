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
    func getTemplateData() -> [BankTemplateEntity]
    func getTransactionData() -> [BankTransactionEntity]
}

final class BankInteractor: BankInteractorProtocol {
    
    weak var presenter: BankPresenterProtocol?
    
    private let cardData = [BankCardEntity(cardColor: "visa", logo: "visa", amount: "$512.5", number: "*3215"),
                    BankCardEntity(cardColor: "mir", logo: "mir", amount: "59,000.99", number: "*5672"),
                    BankCardEntity(cardColor: "mastercard", logo: "mastercard", amount: "$12.5", number: "*5621"),
                    BankCardEntity(cardColor: "american", logo: "american", amount: "$990.0", number: "*6432"),
                    BankCardEntity(cardColor: "mir", logo: "mir", amount: "29,000", number: "*2234")]

    private let templateData = [BankTemplateEntity(image: "phone.fill", label: "Phone number"),
                        BankTemplateEntity(image: "fork.knife", label: "Sunday BBQ"),
                        BankTemplateEntity(image: "4k.tv.fill", label: "Netflix"),
                        BankTemplateEntity(image: "carrot", label: "Amazon Plus"),
                        BankTemplateEntity(image: "photo.tv", label: "HBO Max"),
                        BankTemplateEntity(image: "y.square", label: "Yandex: Kinopoisk")]

    private let transactionData = [BankTransactionEntity(icon: "", name: "Wallmart", date: "14 May 2023", cost: "$99.50", cardNumber: "*3215"),
                           BankTransactionEntity(icon: "", name: "GYM", date: "11 May 2023", cost: "$15.99", cardNumber: "*6432"),
                           BankTransactionEntity(icon: "", name: "Tacobell", date: "9 May 2023", cost: "$25.50", cardNumber: "*3215"),
                           BankTransactionEntity(icon: "", name: "Jack in the Box", date: "25 April 2023", cost: "$15.25", cardNumber: "*6432"),
                           BankTransactionEntity(icon: "", name: "Filippo Berio Store", date: "22 April 2023", cost: "$89.9", cardNumber: "*6432"),
                           BankTransactionEntity(icon: "", name: "Saint Antonio Grocery", date: "10 Aplril 2023", cost: "$189.99", cardNumber: "*3215")]

    
    func viewDidLoaded() {
        
    }
    
    func getCardData() -> [BankCardEntity] {
        return cardData
    }
    
    func getTemplateData() -> [BankTemplateEntity] {
        return templateData
    }
    
    func getTransactionData() -> [BankTransactionEntity] {
        return transactionData
    }
}
