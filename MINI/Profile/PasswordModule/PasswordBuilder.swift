//
//  PasswordBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 08.08.2023.
//

import UIKit

final class PasswordBuilder {
    
    static func build() -> UIViewController {
        let view = PasswordViewController()
        let presenter = PasswordPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
}
