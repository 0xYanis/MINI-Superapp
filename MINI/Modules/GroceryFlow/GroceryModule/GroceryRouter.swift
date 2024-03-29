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
    func goToMapView()
    func goToCart()
}

final class GroceryRouter: GroceryRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailCategory(with id: Int) {
        let categoryView = CategoryBuilder.build()
        open(categoryView, state: .push)
    }
    
    func goToSearchView() {
        let searchView = GSearchBuilder.build()
        open(searchView, state: .push)
    }
    
    func goToMapView() {
        let mapView = MapBuilder.build()
        open(mapView, state: .push)
    }
    
    func goToCart() {
        view?.tabBarController?.selectedIndex = TabItem.cart.rawValue
    }
    
    private func open(_ module: UIViewController, state: NavigationState) {
        switch state {
        case .push:
            view?.navigationController?.push(module)
        case .present:
            view?.present(module, animated: true)
        }
    }
    
    private enum NavigationState {
        case push
        case present
    }
    
}
