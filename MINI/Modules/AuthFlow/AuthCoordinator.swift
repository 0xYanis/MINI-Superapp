//
//  AuthCoordinator.swift
//  MINI
//
//  Created by Yanis on 26.10.2023.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
    weak public var parentCoordinator: MainCoordinator?
    public var childCoordinators: [Coordinator] = []
    public var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    public func start() {
        let login = LoginBuilder.build(coordinator: self)
        navController.setViewControllers([login], animated: true)
    }
    
    public func finish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    public func goToRegistrate() {
        let register = RegisterBuilder.build(coordinator: self)
        navController.push(register)
    }
    
}
