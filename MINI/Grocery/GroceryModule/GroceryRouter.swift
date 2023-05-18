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
        let detailCategoryView = UIViewController()
        detailCategoryView.view.backgroundColor = .wetAsphalt
        view?.navigationController?.pushViewController(detailCategoryView, animated: true)
    }
}
