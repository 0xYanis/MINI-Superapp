//
//  NewCardBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class NewCardBuilder {
    
    static func build() -> UIViewController {
        let viewController = NewCardViewController()
        let router = NewCardRouter()
        let interactor = NewCardInteractor()
        let presenter = NewCardPresenter(router: router, interactor: interactor)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
