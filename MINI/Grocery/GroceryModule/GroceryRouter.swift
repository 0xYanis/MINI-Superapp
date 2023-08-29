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
    func goToCartView()
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
        let mapView = MapViewController()
        open(mapView, state: .push)
    }
    
    func goToCartView() {
        let cartView = CartBuilder.build()
        open(cartView, state: .push)
    }
    
    private func open(_ module: UIViewController, state: NavigationState) {
        switch state {
        case .push:
            view?.navigationController?.pushViewController(module, animated: true)
        case .present:
            view?.present(module, animated: true)
        }
    }
    
    private enum NavigationState {
        case push
        case present
    }
    
}
