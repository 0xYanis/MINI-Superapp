//
//  BankBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit

final class BankBuilder {
    static func build() -> UIViewController {
        let viewController = BankViewController()
        let router = BankRouter()
        let interactor = BankInteractor()
        let presenter = BankPresenter(
            router: router,
            interactor: interactor
        )
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
    
}
