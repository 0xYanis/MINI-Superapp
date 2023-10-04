//
//  ProductRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit

protocol ProductRouterProtocol: AnyObject {
    func goToCart()
}

final class ProductRoter: ProductRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToCart() {
        view?.dismiss(animated: true) { [weak self] in
            self?.view?.tabBarController?.selectedIndex = TabItem.cart.rawValue
        }
    }
    
}
