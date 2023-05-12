//
//  LoginRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func userDidLogin()
}

final class LoginRouter: LoginRouterProtocol {
    weak var view: UIViewController?
    
    func userDidLogin() {
        let nextView = BaseTabBarController()
        var controllers = view?.navigationController?.viewControllers
        controllers?.removeLast()
        controllers?.append(nextView)
        view?.navigationController?.navigationBar.isHidden = true
        view?.navigationController?.setViewControllers(controllers ?? [], animated: true)
    }
}
