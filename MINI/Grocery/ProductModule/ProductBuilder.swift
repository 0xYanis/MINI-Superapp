//
//  ProductBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit

final class ProductBuilder {
    static func build() -> UIViewController {
        let view = ProductViewController()
        let router = ProductRoter()
        let interactor = ProductInteractor()
        let presenter = ProductPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
