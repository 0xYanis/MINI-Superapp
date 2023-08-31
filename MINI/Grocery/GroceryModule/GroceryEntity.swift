//
//  GroceryEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 18.05.2023.
//

import Foundation

struct GroceryEntity: Codable, Equatable {
    let id: Int
    let category: String
    let image: String
    let productName: String
}

enum GroceryType: String {
    case fruit
    case vegetable
    case meat
    case dairy
    case grains
    case snacks
    case beverages
    case seafood
    case spices
    case condiments
    case drinks
    case bread
    case sweets
    case frozenFood
    case cannedFood
    case pasta
    case sauces
    case babyFood
    case petFood
}
