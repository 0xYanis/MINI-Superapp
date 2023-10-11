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
    
    weak public var view: OnboardingViewProtocol?
    weak public var coordinatorDelegate: AppCoordinatorDelegate?
    
    public var content: [OnboardingEntity] = [.first, .second, .third]
    
    init(view: OnboardingViewProtocol) {
        self.view = view
    }
    
    func readyToContinue() {
        UserDefaults.standard.set(true, forKey: "seenOnboarding")
        coordinatorDelegate?.canLaunch()
    }
    
}
