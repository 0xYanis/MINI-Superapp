//
//  LoginRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol LoginRouterProtocol: AnyObject {
    func userDidLogin()
}

final class LoginRouter: LoginRouterProtocol {
    weak var view: LoginViewController?
    
    func userDidLogin() {
        let nextView = BankBuilder.build()
        var controllers = view?.navigationController?.viewControllers
        controllers?.removeLast()
        controllers?.append(nextView)
        view?.navigationController?.setViewControllers(controllers ?? [], animated: true)
    }
}
