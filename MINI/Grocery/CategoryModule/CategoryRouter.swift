//
//  CategoryRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit

protocol CategoryRouterProtocol: AnyObject {
    func goToDetailProduct(index: Int)
    func goToCart()
}

final class CategoryRouter: CategoryRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailProduct(index: Int) {
        let productView = ProductBuilder.build()
        view?.navigationController?.pushViewController(productView, animated: true)
    }
    
    func goToCart() {
        let cartView = UIViewController()
        cartView.view.backgroundColor = .black
        cartView.navigationItem.title = "Cart"
        view?.navigationController?.pushViewController(cartView, animated: true)
    }
}
