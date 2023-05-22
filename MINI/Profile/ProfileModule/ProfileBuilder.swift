//
//  ProfileBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import UIKit

final class ProfileBuilder {
    
    static func build() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        
        return view
    }
    
}
