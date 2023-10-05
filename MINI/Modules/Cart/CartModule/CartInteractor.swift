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
    }
    
    public func setCurrentTag(_ index: Int) {
        guard purchases.count > index else { return }
        filtered.removeAll()
        if tagItems[index] == tagItems.first {
            filtered = purchases
        } else if tagItems[index] == tagItems.last {
            filtered = cancelledPurchases
        } else {
            filtered = purchases.filter { $0.type.rawValue == tagItems[index] }
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
        defer { if purchases.isEmpty { presenter?.showEmptyView() } }
        guard purchases.count > index else { return }
        purchases = purchases.filter { $0.description != filtered[index].description }
        filtered.remove(at: index)
        purchasePriceCount()
        //db.purchases.remove(at: index)
    }
    
    public func removeAll() {
        filtered.removeAll()
        purchases.removeAll()
        //db.purchases.removeAll()
    }
	
}
