//
//  CartRepository.swift
//  MINI
//
//  Created by Yanis on 07.12.2023.
//

import Foundation

protocol CartRepositoryProtocol: AnyObject {
    var purchasesCount: Int { get }
    var totalPrice: Double { get }
    
    func addPurchase(_ purchase: Purchase) throws
    func readPurchase(primaryKey: UUID) -> Purchase?
    func deletePurchase(key: UUID) throws
    func removeAll() throws
    func updatePurchase(_ purchase: Purchase) throws
    func updatePurchaseType(_ type: PurchaseType, with key: UUID) throws
    func fetchPurchases() throws -> [Purchase]
}

final class CartRepository: CartRepositoryProtocol {
    
    private let storage: RealmServiceProtocol
    
    init() {
        self.storage = RealmService()
    }
    
    var purchasesCount: Int {
        (try? storage.fetchAll(PurchaseObject.self).count) ?? 0
    }
    
    var totalPrice: Double {
        (try? storage.fetchAll(PurchaseObject.self).map { $0.price }.reduce(0,+)) ?? 0.0
    }
    
    func addPurchase(_ purchase: Purchase) throws {
        let object = PurchaseObject(purchase)
        try storage.add(object)
    }
    
    func readPurchase(primaryKey: UUID) -> Purchase? {
        guard let object = storage.read(PurchaseObject.self, key: primaryKey)
        else { return nil }
        return Purchase(object)
    }
    
    func deletePurchase(key: UUID) throws {
        try storage.delete(PurchaseObject.self, forKey: key)
    }
    
    func removeAll() throws {
        try storage.deleteAll()
    }
    
    func updatePurchaseType(_ type: PurchaseType, with key: UUID) throws {
        guard var purchase = readPurchase(primaryKey: key) else { return }
        purchase.type = type
        try updatePurchase(purchase)
    }
    
    func updatePurchase(_ purchase: Purchase) throws {
        let object = PurchaseObject(purchase)
        try storage.update(object)
    }
    
    func fetchPurchases() throws -> [Purchase] {
        let objects = try storage.fetchAll(PurchaseObject.self)
        return objects.compactMap { Purchase($0) }
    }
    
    
}
