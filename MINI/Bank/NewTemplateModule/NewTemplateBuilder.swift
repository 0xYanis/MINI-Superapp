//
//  NewTemplateBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 25.04.2023.
//

import UIKit

final class NewTemplateBuilder {
    static func build() -> UIViewController {
        let viewController = NewTemplateViewController()
        let router = NewTemplateRouter()
        let interactor = NewTemplateInteractor()
        let presenter = NewTemplatePresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
    
}
