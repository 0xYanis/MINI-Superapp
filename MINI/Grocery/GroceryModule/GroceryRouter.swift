//
//  GroceryRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit

protocol GroceryRouterProtocol: AnyObject {
    func goToDetailCategory(with id: Int)
    func goToSearchView()
    func goToCartView()
}

final class GroceryRouter: GroceryRouterProtocol {
    weak var view: UIViewController?
    
    func goToDetailCategory(with id: Int) {
        let categoryView = CategoryBuilder.build()
        view?.navigationController?.pushViewController(
            categoryView,
            animated: true
        )
    }
    
    func goToSearchView() {
        let searchView = GSearchBuilder.build()
        view?.navigationController?.pushViewController(
            searchView,
            animated: true
        )
    }
    
    func goToCartView() {
        let cartView = CartBuilder.build()
        view?.navigationController?.pushViewController(
            cartView,
            animated: true
        )
    }
}
