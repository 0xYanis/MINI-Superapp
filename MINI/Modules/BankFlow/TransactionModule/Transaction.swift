//
//  BankTransactionEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct Transaction: Identifiable, Codable {
    var id = UUID().uuidString
    var icon: String?
    var name: String
    var date: String
    var cost: Double
    var cardNumber: Int
    var location: String?
    var currency: String
    var status: String
    var category: String?
    var notes: String
    var merchantID: Int
    var customerID: Int
    
    func mapToDict() -> [String?:String?] {
        return [
            "Владедец карты" : name,
            "Дата транзакции" : date,
            "Стоимость" : "\(cost)",
            "Платежный счет" : "\(cardNumber)",
            "Адресс на карте" : location,
            "Тип валюты" : currency,
            "Статус" : status,
            "Категория" : category,
            "Заметки" : notes,
            "merchantID" : "\(merchantID)",
            "customerID" : "\(customerID)"
        ]
    }
    
    static func convertToTransaction(_ object: TransactionObject) -> Transaction {
        return Transaction(
            id: object.id,
            icon: object.icon,
            name: object.name,
            date: object.date,
            cost: object.cost,
            cardNumber: object.cardNumber,
            location: object.location,
            currency: object.currency,
            status: object.status,
            category: object.category,
            notes: object.notes,
            merchantID: object.merchantID,
            customerID: object.customerID
        )
    }
    
}

class TransactionObject: Object {
    @Persisted var id = UUID().uuidString
    @Persisted var icon: String?
    @Persisted var name: String
    @Persisted var date: String
    @Persisted var cost: Double
    @Persisted var cardNumber: Int
    @Persisted var location: String?
    @Persisted var currency: String
    @Persisted var status: String
    @Persisted var category: String?
    @Persisted var notes: String
    @Persisted var merchantID: Int
    @Persisted var customerID: Int
    
    class func convertToObject(_ transaction: Transaction) -> TransactionObject {
        let object = TransactionObject()
        
        object.id = transaction.id
        object.icon = transaction.icon
        object.name = transaction.name
        object.date = transaction.date
        object.cost = transaction.cost
        object.cardNumber = transaction.cardNumber
        object.location = transaction.location
        object.currency = transaction.currency
        object.status = transaction.status
        object.category = transaction.category
        object.notes = transaction.notes
        object.merchantID = transaction.merchantID
        object.customerID = transaction.customerID
        
        return object
    }

}
