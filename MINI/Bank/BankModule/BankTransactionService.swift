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
            BankTransactionEntity(icon: "", name: "Wallmart", date: "14 May 2023", cost: "$99.50", cardNumber: "*3215"),
            BankTransactionEntity(icon: "", name: "GYM", date: "11 May 2023", cost: "$15.99", cardNumber: "*6432"),
            BankTransactionEntity(icon: "", name: "Tacobell", date: "9 May 2023", cost: "$25.50", cardNumber: "*3215"),
            BankTransactionEntity(icon: "", name: "Jack in the Box", date: "25 April 2023", cost: "$15.25", cardNumber: "*6432"),
            BankTransactionEntity(icon: "", name: "Filippo Berio Store", date: "22 April 2023", cost: "$89.9", cardNumber: "*6432"),
            BankTransactionEntity(icon: "", name: "Saint Antonio Grocery", date: "10 Aplril 2023", cost: "$189.99", cardNumber: "*3215")
        ]
        
        completion(.success(transactionData))
    }
    
    
}
