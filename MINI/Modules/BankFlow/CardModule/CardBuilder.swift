//
//  CardBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class CardBuilder {
    static func build(with id: UUID) -> UIViewController {
        let viewController = CardViewController()
        let router = CardRouter()
        let interactor = CardInteractor(id)
        let presenter = CardPresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
    
}
