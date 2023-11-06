//
//  CartInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

protocol CartInteractorProtocol: AnyObject {
    var filtered: [Purchase] { get }
    var tagItems: [String] { get }
    func setCurrentTag(_ index: Int)
    
    func viewWillAppear()
    func deleteCell(at index: Int)
    func removeAll()
}

final class CartInteractor: CartInteractorProtocol {
	
    //MARK: - Public properties
    
	weak var presenter: CartPresenterProtocol?
    
    public var filtered: [Purchase] = mockPurchase
    public var tagItems: [String] = ["Все","Продукты","Товары","Билеты","Отмененные"]
    
    //MARK: - Private properties
    
    private var purchases: [Purchase] = mockPurchase
    private var cancelledPurchases: [Purchase] = []
    private var totalPrice: Double = 0.0 {
        didSet { presenter?.updateOrder(quantity: filtered.count, with: totalPrice) }
    }
    
    //MARK: - Public methods
    
    public func viewWillAppear() {
        purchasePriceCount()
        purchasesCounter()
    }
    
    public func setCurrentTag(_ index: Int) {
        guard purchases.count > index else { return }
        filtered.removeAll()
        
        switch tagItems[index] {
        case tagItems.first: filtered = purchases
        case tagItems.last:  filtered = cancelledPurchases
        default: filtered = purchases.filter { $0.type.rawValue == tagItems[index] }
        }
        
        presenter?.updateView()
        purchasePriceCount()
    }
    
    public func purchasePriceCount() {
        if purchases.isEmpty { self.totalPrice = 0.0; return }
        self.totalPrice = filtered
            .compactMap { $0.price }
            .reduce(0, +)
            .rounded()
    }
    
    public func deleteCell(at index: Int) {
        defer { if purchases.isEmpty && cancelledPurchases.isEmpty { presenter?.showEmptyView() } }
        guard purchases.count > index else { return }
        
        addCancelledPurchase(filtered[index])
        
        purchases = purchases.filter { $0.description != filtered[index].description }
        filtered.remove(at: index)
        purchasePriceCount()
        purchasesCounter()
        //db.purchases.remove(at: index)
    }
    
    private func addCancelledPurchase(_ purchase: Purchase) {
        if filtered.containsSameElements(as: cancelledPurchases) {
            cancelledPurchases = cancelledPurchases.filter { $0.description != purchase.description }
        } else {
            cancelledPurchases.append(purchase)
        }
        
    }
    
    public func removeAll() {
        filtered.removeAll()
        purchases.removeAll()
        purchasesCounter()
        //db.purchases.removeAll()
    }
    
    private func purchasesCounter() {
        presenter?.updateBadge(newValue: purchases.count)
    }
	
}
