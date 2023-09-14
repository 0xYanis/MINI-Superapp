//
//  CartInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

protocol CartInteractorProtocol: AnyObject {
    var tagItems: [String] { get }
    func setCurrentTag(_ index: Int)
}

final class CartInteractor: CartInteractorProtocol {
	
	weak var presenter: CartPresenterProtocol?
    
    public var tagItems: [String] = [
        "Все","Избранное","Продукты",
        "Товары","Билеты", "Заказы",
        "Отмененные"
    ]
    
    func setCurrentTag(_ index: Int) {
        
    }
	
}
