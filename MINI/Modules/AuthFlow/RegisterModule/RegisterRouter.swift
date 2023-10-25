//
//  RegisterRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit

protocol RegisterRouterProtocol: AnyObject {
    func userDidRegister()
}

final class RegisterRouter: RegisterRouterProtocol {
    
    weak private var view: UIViewController?
    weak private var coordinator: LoginCoordinator?
    
    init(view: UIViewController, coordinator: LoginCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func userDidRegister() {
        coordinator?.finish()
    }
    
}
