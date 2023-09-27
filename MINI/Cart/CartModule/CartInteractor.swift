//
//  CartInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

protocol CartInteractorProtocol: AnyObject {
    var purchases: [Purchase] { get }
    var tagItems: [String] { get }
    func setCurrentTag(_ index: Int)
    
    func viewWillAppear()
    func deleteCell(at index: Int)
    func removeAll()
}

final class CartInteractor: CartInteractorProtocol {
	
	weak var presenter: CartPresenterProtocol?
    
    public var purchases: [Purchase] = mockPurchase
    public var tagItems: [String] = [
        "Все","Избранное","Продукты",
        "Товары","Билеты", "Заказы",
        "Отмененные"]
    private var totalPrice: Double = 0.0 {
        didSet { presenter?.updateView(quantity: purchases.count, with: totalPrice) }
    }
    
    public func viewWillAppear() {
        purchasePriceCount()
    }
    
    public func setCurrentTag(_ index: Int) {
        
    }
    
    public func purchasePriceCount() {
        if purchases.isEmpty { return }
        let totalPrice = purchases
            .compactMap { $0.price }
            .reduce(0, +)
            .rounded()
        self.totalPrice = totalPrice
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
