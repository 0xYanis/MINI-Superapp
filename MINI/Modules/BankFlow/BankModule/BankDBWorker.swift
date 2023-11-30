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
    func addTemplate(_ template: Template) throws
    func deleteTemplate(_ template: Template) throws
    func updateTemplate(_ template: Template) throws
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
    
    func addTemplate(_ template: Template) throws {
        let object = TemplateObject.convertToTempObject(tempStruct: template)
        try realmService.add(object)
    }
    
    func deleteTemplate(_ template: Template) throws {
        let object = TemplateObject.convertToTempObject(tempStruct: template)
        try realmService.delete(object)
    }
    
    func updateTemplate(_ template: Template) throws {
        let object = TemplateObject.convertToTempObject(tempStruct: template)
        try realmService.update(object)
    }
    
    func fetchTemplates() -> [Template] {
        guard
            let results = realmService.fetch(TemplateObject.self)
        else { return [] }
        return results.compactMap { tempObj in
            Template.convertToTempStruct(tempObject: tempObj)
        }
    }
    
}

extension BankDBWorker: TransactionDBProtocol {
    
    func addTransaction(_ transaction: Transaction) throws {
        let object = TransactionObject.convertToObject(transaction)
        try realmService.add(object)
    }
    
    func deleteTransaction(_ transaction: Transaction) throws {
        let object = TransactionObject.convertToObject(transaction)
        try realmService.delete(object)
    }
    
    func updateTransaction(_ transaction: Transaction) throws {
        let object = TransactionObject.convertToObject(transaction)
        try realmService.update(object)
    }
    
    func fetchTransactions() -> [Transaction] {
        guard
            let results = realmService.fetch(TransactionObject.self)
        else { return [] }
        return results.compactMap { object in
            Transaction.convertToTransaction(object)
        }
    }
    
}
