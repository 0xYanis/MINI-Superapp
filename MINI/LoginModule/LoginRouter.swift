//
//  LoginRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation
import UIKit
protocol LoginRouterProtocol: AnyObject {
    func userDidLogin()
}

final class LoginRouter: LoginRouterProtocol {
    weak var view: LoginViewController?
    
    func userDidLogin() {
        let nextView = UIViewController()
        nextView.view.backgroundColor = .white
        self.view?.navigationController?.pushViewController(nextView, animated: true)
    }
}
