//
//  GroceryBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit

final class GroceryBuilder {
    
    static func build() -> UIViewController {
        let groceryService = GroceryService()
        let locationService = LocationService()
        let placemarkService = PlacemarkService()
        let fbFirestoreManager = FBFirestoreManager()
        
        let view = GroceryViewController()
        let router = GroceryRouter()
        let interactor = GroceryInteractor(
            groceryService: groceryService,
            locationService: locationService,
            placemarkService: placemarkService,
            fbFirestoreManager: fbFirestoreManager)
        let presenter = GroceryPresenter(
            router: router,
            interactor: interactor)

        presenter.view = view
        view.presenter = presenter
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
