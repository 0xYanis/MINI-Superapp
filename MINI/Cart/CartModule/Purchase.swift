//
//  Purchase.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

struct Purchase {
    var name: String
    var image: String = "AppIcon"
    var type: PurchaseType
    var description: String
    var quantity: Int
    var price: Double
    
    static var mockData: [Purchase] = [
        .init(name: "Nike Air Max 90", type: .product, description: "Культовые кроссовки из 90-ых", quantity: 1, price: 96.99),
        .init(name: "MSC - SPB", type: .ticket, description: "Вылет:\n21/09, 13:05", quantity: 1, price: 35.50),
        .init(name: "Стейк Рибай", type: .grocery, description: "Говядина Black Angus", quantity: 3, price: 69.99),
        .init(name: "Пицца Маргарита", type: .grocery, description: "Состав: тесто, томатный соус, сыр моцарелла", quantity: 1, price: 13.99)
    ]
    
}

enum PurchaseType: String {
    case grocery = "Продукты"
    case product = "Товары"
    case ticket  = "Билеты"
}
