//
//  BankDBWorker.swift
//  MINI
//
//  Created by Yanis on 30.11.2023.
//

import Foundation

protocol CardDBProtocol: AnyObject {
    func addCard(_ card: Card) throws
    func deleteCard(_ card: Card) throws
    func updateCard(_ card: Card) throws
    func fetchCards() -> [Card]
}

protocol TemplateDBProtocol: AnyObject {
    func addTemplate(_ card: Template) throws
    func deleteTemplate(_ card: Template) throws
    func updateTemplate(_ card: Template) throws
    func fetchTemplates() -> [Template]
}

protocol TransactionDBProtocol: AnyObject {
    func addTransaction(_ transaction: Transaction) throws
    func deleteTransaction(_ transaction: Transaction) throws
    func updateTransaction(_ transaction: Transaction) throws
    func fetchTransactions() -> [Transaction]
}

final class BankDBWorker {
    
    private var realmService: RealmServiceProtocol
    
    init() {
        self.realmService = RealmService()
    }
    
}

extension BankDBWorker: CardDBProtocol {
    
    func addCard(_ card: Card) throws {
        let object = CardObject.convertToCardObject(card: card)
        try realmService.add(object)
    }
    
    func deleteCard(_ card: Card) throws {
        let object = CardObject.convertToCardObject(card: card)
        try realmService.delete(object)
    }
    
    func updateCard(_ card: Card) throws {
        let object = CardObject.convertToCardObject(card: card)
        try realmService.update(object)
    }
    
    func fetchCards() -> [Card] {
        guard
            let results = realmService.fetch(CardObject.self)
        else { return [] }
        return results.compactMap { cardObj in
            Card.convertToCardStruct(cardObject: cardObj)
        }
    }
    
}

extension BankDBWorker: TemplateDBProtocol {
    
    func addTemplate(_ card: Template) throws {
        
    }
    
    func deleteTemplate(_ card: Template) throws {
        
    }
    
    func updateTemplate(_ card: Template) throws {
        
    }
    
    func fetchTemplates() -> [Template] {
        []
    }
    
}

extension BankDBWorker: TransactionDBProtocol {
    
    func addTransaction(_ transaction: Transaction) throws {
        
    }
    
    func deleteTransaction(_ transaction: Transaction) throws {
        
    }
    
    func updateTransaction(_ transaction: Transaction) throws {
        
    }
    
    func fetchTransactions() -> [Transaction] {
        []
    }
    
}
