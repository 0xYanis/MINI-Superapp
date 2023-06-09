//
//  FoodBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit

final class FoodBuilder {
    static func build() -> UIViewController {
        let view = FoodViewController()
        let router = FoodRouter()
        let interactor = FoodInteractor()
        let presenter = FoodPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
}
