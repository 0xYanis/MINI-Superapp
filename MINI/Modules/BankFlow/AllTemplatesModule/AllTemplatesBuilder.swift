//
//  AllTemplatesBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit

final class AllTemplatesBuilder {
    static func build(with data: [Template]) -> UIViewController {
        let viewController = AllTemplatesViewController()
        let router = AllTemplatesRouter()
        let interactor = AllTemplatesInteractor(tempaltes: data)
        let presenter = AllTemplatesPresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
    
}
