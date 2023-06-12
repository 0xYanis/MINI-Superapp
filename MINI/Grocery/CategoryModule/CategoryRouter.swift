//
//  CategoryRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit

protocol CategoryRouterProtocol: AnyObject {
    func goToDetailProduct(index: Int)
}

final class CategoryRouter: CategoryRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailProduct(index: Int) {
        let productView = ProductBuilder.build()
        view?.navigationController?.pushViewController(productView, animated: true)
    }
}
