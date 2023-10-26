//
//  TabBarCoordinator.swift
//  MINI
//
//  Created by Yanis on 26.10.2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    weak public var parentCoordinator: MainCoordinator?
    public var childCoordinators: [Coordinator] = []
    public var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    public func start() {
        // TODO: [Костыль] Навбар имеет Таббар, который внутри имеет навбары
        let tabBar = BaseTabBarController()
        tabBar.coordinator = self
        navController.setViewControllers([tabBar], animated: false)
        navController.isNavigationBarHidden = true
    }
    
    func finish() {
        navController.popViewController(animated: false)
        parentCoordinator?.childDidFinish(self)
    }
    
}
