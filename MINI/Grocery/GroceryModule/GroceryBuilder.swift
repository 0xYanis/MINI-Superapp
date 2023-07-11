//
//  GroceryBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit

final class GroceryBuilder {
    static func build() -> UIViewController {
        let view = GroceryViewController()
        let groceryService = GroceryService()
        let interactor = GroceryInteractor(groceryService: groceryService)
        let router = GroceryRouter()
        let presenter = GroceryPresenter(router: router, interactor: interactor)
        
        presenter.view = view
        view.presenter = presenter
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
