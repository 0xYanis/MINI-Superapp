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
	
	weak var presenter: CartPresenterProtocol?
    
    public var filtered: [Purchase] = mockPurchase
    
    public var tagItems: [String] = [
        "Все","Избранное","Продукты",
        "Товары","Билеты", "Заказы",
        "Отмененные"]
    private var purchases: [Purchase] = mockPurchase
    private var totalPrice: Double = 0.0 {
        didSet { presenter?.updateOrder(quantity: filtered.count, with: totalPrice) }
    }
    
    public func viewWillAppear() {
        purchasePriceCount()
    }
    
    public func setCurrentTag(_ index: Int) {
        guard purchases.count > index else { return }
        filtered.removeAll()
        if tagItems[index] == tagItems.first {
            filtered = purchases
        } else {
            filtered = purchases.filter { $0.type.rawValue == tagItems[index] }
        }
        presenter?.updateView()
        purchasePriceCount()
    }
    
    public func purchasePriceCount() {
        if purchases.isEmpty { return }
        self.totalPrice = filtered
            .compactMap { $0.price }
            .reduce(0, +)
            .rounded()
    }
    
    public func deleteCell(at index: Int) {
        if index < purchases.count {
            purchases.remove(at: index)
        }
    }
    
    public func removeAll() {
        purchases.removeAll()
        //db.purchases.removeAll()
    }
	
}
