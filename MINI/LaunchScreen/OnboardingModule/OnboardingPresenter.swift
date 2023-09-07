//
//  OnboardingPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    var content: [OnboardingEntity] { get }
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    
    weak public var view: OnboardingViewProtocol?
    
    public var content: [OnboardingEntity] = [.first, .second, .third]
    
    init(view: OnboardingViewProtocol) {
        self.view = view
    }
    
}
