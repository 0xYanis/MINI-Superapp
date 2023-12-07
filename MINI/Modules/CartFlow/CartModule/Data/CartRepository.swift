//
//  CartRepository.swift
//  MINI
//
//  Created by Yanis on 07.12.2023.
//

import Foundation

protocol CartRepositoryProtocol: AnyObject {
    func addPurchase(_ purchase: Purchase) throws
    func readPurchase(primaryKey: UUID) -> Purchase?
    func deletePurchase(key: UUID) throws
    func updatePurchase(_ purchase: Purchase) throws
    func fetchPurchases() throws -> [Purchase]
}

final class CartRepository: CartRepositoryProtocol {
    
    private let storage: RealmServiceProtocol
    
    init() {
        self.storage = RealmService()
    }
    
    func addPurchase(_ purchase: Purchase) throws {
        
    }
    
    func readPurchase(primaryKey: UUID) -> Purchase? {
        nil
    }
    
    func deletePurchase(key: UUID) throws {
        
    }
    
    func updatePurchase(_ purchase: Purchase) throws {
        
    }
    
    func fetchPurchases() throws -> [Purchase] {
        []
    }
    
    
}
