//
//  PaymentBuilder.swift
//  MINI
//
//  Created by Yanis on 16.10.2023.
//

import UIKit

final class PaymentBuilder {
    
    static func build() -> UIViewController {
        let view = PaymentViewController()
        let router = PaymentRouter()
        let interactor = PaymentInteractor()
        let presenter = PaymentPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
}
