//
//  GroceryEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 18.05.2023.
//

import Foundation

struct Grocery {
    var type: GroceryType
    var items: [GroceryItem]
}

struct GroceryItem: Identifiable {
    var id = UUID().uuidString
    var image: String
    var productName: String
    var isSale: Bool
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

let groceryItems = [
    Grocery(type: .fruit, items: [
        GroceryItem(image: "https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Apple", isSale: false),
        GroceryItem(image: "https://images.unsplash.com/photo-1587132137056-bfbf0166836e?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Banana", isSale: true),
        GroceryItem(image: "https://images.unsplash.com/photo-1557800636-894a64c1696f?q=80&w=1665&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Orange", isSale: false)
    ]),
    Grocery(type: .vegetable, items: [
        GroceryItem(image: "https://images.unsplash.com/photo-1615485291234-9d694218aeb3?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Broccoli", isSale: false),
        GroceryItem(image: "https://images.unsplash.com/photo-1576181256399-834e3b3a49bf?q=80&w=1750&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Carrot", isSale: true),
        GroceryItem(image: "https://images.unsplash.com/photo-1587411768638-ec71f8e33b78?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Cucumber", isSale: true)
    ]),
    Grocery(type: .meat, items: [
        GroceryItem(image: "https://images.unsplash.com/photo-1598103442097-8b74394b95c6?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Chicken", isSale: false),
        GroceryItem(image: "https://images.unsplash.com/photo-1603048297172-c92544798d5a?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Beef", isSale: false),
        GroceryItem(image: "https://images.unsplash.com/photo-1591912310355-a5a7b85ddc85?q=80&w=1788&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", productName: "Pork", isSale: false)
    ]),
    Grocery(type: .dairy, items: [
        GroceryItem(image: "https://images.unsplash.com/photo-1603576120227-14c2f2f612d5?q=80&w=1880&auto=format&fit=crop&ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9", productName: "Milk", isSale: true)
    ])
]
