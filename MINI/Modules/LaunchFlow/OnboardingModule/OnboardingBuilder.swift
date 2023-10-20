//
//  OnboardingBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import UIKit

final class OnboardingBuilder {
    
    static func build() -> UIViewController {
        let view = OnboardingPageController()
        let presenter = OnboardingPresenter(view: view)
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
}
