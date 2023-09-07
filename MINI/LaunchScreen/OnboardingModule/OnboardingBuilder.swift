//
//  OnboardingBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import UIKit

final class OnboardingBuilder {
    
    static func build() -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
}
