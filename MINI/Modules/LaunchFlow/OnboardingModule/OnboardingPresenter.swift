//
//  OnboardingPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    var content: [OnboardingEntity] { get }
    
    func readyToContinue()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    
    weak private var view: OnboardingViewProtocol?
    weak private var coordinator: OnBoardingCoordinator?
    
    public var content: [OnboardingEntity] = [.first, .second, .third]
    
    init(
        view: OnboardingViewProtocol,
        coordinator: OnBoardingCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        
        view.setData(entities: content)
    }
    
    func readyToContinue() {
        UserDefaults.standard.set(true, forKey: "seenOnboarding")
        coordinator?.finish()
    }
    
}
