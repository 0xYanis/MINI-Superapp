//
//  Purchase.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation
import RealmSwift

struct Purchase: Comparable {
    var id: UUID
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

extension Purchase {
   init(_ object: PurchaseObject) {
       self.id = object.id
       self.name = object.name
       self.type = object.type
       self.description = object.descriptionObj
       self.quantity = object.quantity
       self.price = object.price
   }
}

enum PurchaseType: String, PersistableEnum {
    case all      = "Все"
    case grocery  = "Продукты"
    case product  = "Товары"
    case ticket   = "Билеты"
    case canceled = "Отмененные"
    
    static var array: [String] {
        [
            PurchaseType.all.rawValue,
            PurchaseType.grocery.rawValue,
            PurchaseType.product.rawValue,
            PurchaseType.ticket.rawValue,
            PurchaseType.canceled.rawValue
        ]
    }
}

var mockPurchase: [Purchase] = [
    .init(id: .init(), name: "Nike Air Max 90", type: .product, description: "Культовые кроссовки из 90-ых", quantity: 1, price: 96.99),
    .init(id: .init(), name: "MSC - SPB", type: .ticket, description: "Вылет:\n21/09, 13:05", quantity: 1, price: 35.50),
    .init(id: .init(), name: "Стейк Рибай", type: .grocery, description: "Говядина Black Angus", quantity: 3, price: 69.99),
    .init(id: .init(), name: "Пицца Маргарита", type: .grocery, description: "Состав: тесто, томатный соус, сыр моцарелла", quantity: 1, price: 13.99),
    .init(id: .init(), name: "Наушники Sony WH-1000XM4", type: .product, description: "Беспроводные наушники с активным шумоподавлением", quantity: 1, price: 349.99),
    .init(id: .init(), name: "Apple Watch Series 6", type: .product, description: "Умные часы с возможностью отслеживания активности", quantity: 1, price: 399.99),
    .init(id: .init(), name: "Samsung 4K Smart TV", type: .product, description: "Телевизор с разрешением 4K и функцией Smart TV", quantity: 1, price: 699.99)
]
