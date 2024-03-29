//
//  OnBoardingCoordinator.swift
//  MINI
//
//  Created by Yanis on 26.10.2023.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
    
    weak public var parentCoordinator: MainCoordinator?
    public var childCoordinators: [Coordinator] = []
    public var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let onBoarding = OnboardingBuilder.build(coordinator: self)
        navController.setViewControllers([onBoarding], animated: false)
    }
    
    func finish() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
