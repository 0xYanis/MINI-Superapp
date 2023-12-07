//
//  CartInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

protocol CartInteractorProtocol: AnyObject {
    var filtered: [Purchase] { get }
    func setCurrentTag(_ index: Int)
    
    func viewWillAppear()
    func deleteCell(at index: Int)
    func removeAll()
}

final class CartInteractor: CartInteractorProtocol {
    
    // MARK: - Public properties
    
    weak var presenter: CartPresenterProtocol?
    
    public var filtered: [Purchase] = mockPurchase
    
    // MARK: - Private properties
    
    private var cartRepository: CartRepositoryProtocol
    private var purchases: [Purchase] = mockPurchase
    private var totalPrice: Double = 0.0 {
        didSet { presenter?.updateOrder(quantity: totalPrice == 0.0 ? 0 : filtered.count, with: totalPrice) }
    }
    
    // MARK: - Lifecycle
    
    init() {
        self.cartRepository = CartRepository()
    }
    
    // MARK: - Public methods
    
    public func viewWillAppear() {
        purchasePriceCount()
        purchasesCounter()
    }
    
    public func setCurrentTag(_ index: Int) {
        filtered.removeAll()
        guard PurchaseType.array.indices.contains(index) else { return }
        let currentString = PurchaseType.array[index]
        switch currentString {
        case PurchaseType.all.rawValue:
            filtered = purchases.filter { $0.type.rawValue != PurchaseType.canceled.rawValue }
            purchasePriceCount()
        case PurchaseType.canceled.rawValue:
            filtered = purchases.filter { $0.type.rawValue == currentString }
            totalPrice = 0.0
        default:
            filtered = purchases.filter { $0.type.rawValue == currentString }
            purchasePriceCount()
        }
        presenter?.updateView()
    }
    
    public func purchasePriceCount() {
        if purchases.isEmpty { self.totalPrice = 0.0; return }
        self.totalPrice = filtered
            .compactMap { $0.price }
            .reduce(0, +)
            .rounded()
    }
    
    public func deleteCell(at index: Int) {
        defer { if purchases.isEmpty { presenter?.showEmptyView() } }
        guard purchases.indices.contains(index),
              filtered.indices.contains(index)
        else { return }
        guard let secondIndex = purchases.firstIndex(of: filtered[index]) else { return }
        
        filtered.remove(at: index)
        
        if purchases[secondIndex].type != PurchaseType.canceled {
            purchases[secondIndex].type = PurchaseType.canceled
        } else {
            purchases.remove(at: secondIndex)
        }
        
        purchasePriceCount()
        purchasesCounter()
        //db.remove()
    }
    
    public func removeAll() {
        purchases.removeAll()
        filtered.removeAll()
        purchasesCounter()
    }
    
    // MARK: - Private methods
    
    private func purchasesCounter() {
        presenter?.updateBadge(newValue: purchases.count)
    }
    
}

// MARK: - Data layler methods

extension CartInteractor {
    
    func deletePurchase(key: UUID) {
        try? cartRepository.deletePurchase(key: key)
    }
    
    func removeAllPurchases() {
        try? cartRepository.removeAll()
    }
    
    func fetchPurchases() {
        guard let purchases = try? cartRepository.fetchPurchases()
        else { return }
        self.purchases = purchases
        self.filtered = purchases
    }
    
    func updatePurchaseType(key: UUID, newType: PurchaseType) {
        try? cartRepository.updatePurchaseType(newType, with: key)
    }
    
    func updateQuantity(key: UUID, newValue: Int) {
        // TODO:
    }
    
}
