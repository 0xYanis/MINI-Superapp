//
//  BankBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit

final class BankBuilder {
    static func build() -> UIViewController {
        let apiService = APIService()
        let realmService = RealmService()
        let cardService = BankCardService(apiService: apiService)
        let templateService = BankTemplateService()
        let transactionService = BankTransactionService()
        
        let viewController = BankViewController()
        let router = BankRouter()
        let interactor = BankInteractor(
            realmService: realmService,
            cardService: cardService,
            templateService: templateService,
            transactionService: transactionService
        )
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
