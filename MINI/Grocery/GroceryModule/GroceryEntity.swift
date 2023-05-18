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
