//
//  CategoryBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit

final class CategoryBuilder {
    static func build() -> UIViewController {
        let view = CategoryViewController()
        let router = CategoryRouter()
        let interactor = CategoryInteractor()
        let presenter = CategoryPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
}
