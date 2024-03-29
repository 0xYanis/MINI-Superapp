//
//  PayoutsBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import UIKit

final class PayoutsBuilder {
    
    static func build(_ type: PayoutsType) -> UIViewController {
        let view = PayoutsViewController()
        let router = PayoutsRouter()
        let interactor = PayoutsInteractor()
        let presenter = PayoutsPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        presenter.type = type
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
