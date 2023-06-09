//
//  GroceryRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit

protocol GroceryRouterProtocol: AnyObject {
    func goToDetailCategory(with id: Int)
}

final class GroceryRouter: GroceryRouterProtocol {
    weak var view: UIViewController?
    
    func goToDetailCategory(with id: Int) {
        let foodView = FoodBuilder.build()
        view?.navigationController?.pushViewController(foodView, animated: true)
    }
}
