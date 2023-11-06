//
//  Purchase.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

struct Purchase: Comparable {
    var name: String
    var image: String = "AppIcon"
    var type: PurchaseType
    var description: String
    var quantity: Int
    var price: Double
    
    static func < (lhs: Purchase, rhs: Purchase) -> Bool {
        return lhs.name < rhs.name
    }
}

enum PurchaseType: String {
    case grocery = "Продукты"
    case product = "Товары"
    case ticket  = "Билеты"
}

var mockPurchase: [Purchase] = [
    .init(name: "Nike Air Max 90", type: .product, description: "Культовые кроссовки из 90-ых", quantity: 1, price: 96.99),
    .init(name: "MSC - SPB", type: .ticket, description: "Вылет:\n21/09, 13:05", quantity: 1, price: 35.50),
    .init(name: "Стейк Рибай", type: .grocery, description: "Говядина Black Angus", quantity: 3, price: 69.99),
    .init(name: "Пицца Маргарита", type: .grocery, description: "Состав: тесто, томатный соус, сыр моцарелла", quantity: 1, price: 13.99),
    .init(name: "Наушники Sony WH-1000XM4", type: .product, description: "Беспроводные наушники с активным шумоподавлением", quantity: 1, price: 349.99),
    .init(name: "Apple Watch Series 6", type: .product, description: "Умные часы с возможностью отслеживания активности", quantity: 1, price: 399.99),
    .init(name: "Samsung 4K Smart TV", type: .product, description: "Телевизор с разрешением 4K и функцией Smart TV", quantity: 1, price: 699.99)
]
