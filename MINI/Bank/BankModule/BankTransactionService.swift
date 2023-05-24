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
    
    func getTransactionsData(completion: @escaping(Result<[BankTransactionEntity]?, Error>) -> Void) {
        let transactionData = [
            BankTransactionEntity(id: 1, icon: nil, name: "Payment", date: "2022-07-20", cost: 45.99, cardNumber: 1234, location: "New York City", currency: "USD", status: "Completed", category: "Shopping", notes: "Bought clothes", merchantID: 123456, customerID: 987654),
            BankTransactionEntity(id: 2, icon: nil, name: "Restaurant", date: "2022-07-19", cost: 32.45, cardNumber: 5678, location: "Los Angeles", currency: "USD", status: "Completed", category: "Food", notes: "Had lunch with friends", merchantID: 234567, customerID: 876543),
            BankTransactionEntity(id: 3, icon: nil, name: "Transportation", date: "2022-07-18", cost: 15.75, cardNumber: 9012, location: "Paris", currency: "EUR", status: "Completed", category: "Travel", notes: "Took a taxi to the hotel", merchantID: 345678, customerID: 765432),
            BankTransactionEntity(id: 4, icon: nil, name: "Entertainment", date: "2022-07-17", cost: 25.0, cardNumber: 3456, location: "London", currency: "GBP", status: "Completed", category: "Leisure", notes: "Watched a movie", merchantID: 456789, customerID: 654321),
            BankTransactionEntity(id: 5, icon: nil, name: "Coffee shop", date: "2022-07-16", cost: 3.99, cardNumber: 7890, location: "Seattle", currency: "USD", status: "Completed", category: "Food", notes: "Bought coffee", merchantID: 567890, customerID: 543210),
            BankTransactionEntity(id: 6, icon: nil, name: "Bookstore", date: "2022-07-15", cost: 17.5, cardNumber: 2345, location: "Boston", currency: "USD", status: "Completed", category: "Shopping", notes: "Bought a book", merchantID: 678901, customerID: 432109),
            BankTransactionEntity(id: 7, icon: nil, name: "Clothing store", date: "2022-07-14", cost: 65.0, cardNumber: 6789, location: "San Francisco", currency: "USD", status: "Completed", category: "Shopping", notes: "Bought a dress", merchantID: 789012, customerID: 321098),
            BankTransactionEntity(id: 8, icon: nil, name: "Gift shop", date: "2022-07-13", cost: 20.0, cardNumber: 1234, location: "Vancouver", currency: "CAD", status: "Completed", category: "Shopping", notes: "Bought a souvenir", merchantID: 890123, customerID: 210987),
            BankTransactionEntity(id: 9, icon: nil, name: "Hotel", date: "2022-07-12", cost: 120.0, cardNumber: 5678, location: "Sydney", currency: "AUD", status: "Completed", category: "Travel", notes: "Stayed at a hotel", merchantID: 901234, customerID: 109876),
            BankTransactionEntity(id: 10, icon: nil, name: "Medical", date: "2022-07-11", cost: 50.0, cardNumber: 9012, location: "Tokyo", currency: "JPY", status: "Completed", category: "Medical", notes: "Visited a doctor", merchantID: 123456, customerID: 098765)
        ]

        
        completion(.success(transactionData))
    }
    
    
}
