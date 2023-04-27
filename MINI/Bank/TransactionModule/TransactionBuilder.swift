//
//  TransactionBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit

final class TransactionBuilder {
    
    static func build() -> UIViewController {
        let viewController = TransactionViewController()
        let router = TransactionRouter()
        let interactor = TransactionInteractor()
        let presenter = TransactionPresenter(router: router, interactor: interactor)
        viewController.presenter = presenter
        router.view = viewController
        presenter.view = viewController
        interactor.presenter = presenter
        return viewController
    }
    
}
