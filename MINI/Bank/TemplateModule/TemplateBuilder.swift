//
//  TemplateBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 28.04.2023.
//

import UIKit

final class TemplateBuilder {
    static func build() -> UIViewController {
        let viewController = TemplateViewController()
        let interactor = TemplateInteractor()
        let router = TemplateRouter()
        let presenter = TemplatePresenter(interactor: interactor, router: router)
        
        viewController.presenter = presenter
        presenter.view = viewController
        router.view = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
