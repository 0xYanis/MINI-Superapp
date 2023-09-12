//
//  AviaBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import UIKit

final class AviaBuilder {
    static func build() -> UIViewController {
        let viewController = AviaViewController()
        let router = AviaRouter()
        let interactor = AviaInteractor()
        let presenter = AviaPresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
    
}
