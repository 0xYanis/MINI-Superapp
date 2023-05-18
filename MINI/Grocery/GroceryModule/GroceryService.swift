//
//  GroceryService.swift
//  MINI
//
//  Created by Yan Rybkin on 18.05.2023.
//

import Foundation

protocol GroceryServiceProtocol: AnyObject {
    func getGroceryData(completion: @escaping(Result<[[GroceryEntity]]?, Error>) -> Void)
}

final class GroceryService: GroceryServiceProtocol {
    func getGroceryData(completion: @escaping (Result<[[GroceryEntity]]?, Error>) -> Void) {
        let groceryData = [
            [GroceryEntity(id: 0, category: "", image: "burger", productName: "Big mac with extra cheese"),
             GroceryEntity(id: 1, category: "", image: "burger", productName: "Whopper with bacon and cheese"),
             GroceryEntity(id: 2, category: "", image: "burger", productName: "Double cheeseburger"),
             GroceryEntity(id: 3, category: "", image: "burger", productName: "Mushroom Swiss burger")
            ],
            [GroceryEntity(id: 0, category: "", image: "burger", productName: "Royale with Cheese"),
             GroceryEntity(id: 1, category: "", image: "burger", productName: "Quarter Pounder with Cheese"),
             GroceryEntity(id: 2, category: "", image: "burger", productName: "Baconator")
            ],
            [GroceryEntity(id: 0, category: "", image: "burger", productName: "In-N-Out Double Double"),
             GroceryEntity(id: 1, category: "", image: "burger", productName: "Animal-Style Burger"),
             GroceryEntity(id: 2, category: "", image: "burger", productName: "Big Carl"),
             GroceryEntity(id: 3, category: "", image: "burger", productName: "Western Bacon Cheeseburger"),
             GroceryEntity(id: 4, category: "", image: "burger", productName: "Double-Double")
            ],
            [GroceryEntity(id: 0, category: "", image: "burger", productName: "McChicken Sandwich"),
             GroceryEntity(id: 1, category: "", image: "burger", productName: "Original Chicken Sandwich")
            ],
            [GroceryEntity(id: 0, category: "", image: "burger", productName: "Jucy Lucy"),
             GroceryEntity(id: 1, category: "", image: "burger", productName: "Prime Rib Burger"),
             GroceryEntity(id: 2, category: "", image: "burger", productName: "Patty Melt")
            ]
        ]
        
        
        completion(.success(groceryData))
    }
}
