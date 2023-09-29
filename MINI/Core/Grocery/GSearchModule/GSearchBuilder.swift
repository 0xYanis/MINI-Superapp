//
//  GSearchBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 22.06.2023.
//

import UIKit

final class GSearchBuilder {
    
    static func build() -> UIViewController {
        let view = GSearchViewController()
        let router = GSearchRouter()
        let interactor = GSearchInteractor()
        let presenter = GSearchPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
