//
//  LoginRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 07.04.2023.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: AnyObject {
    func openAuthModule()
    func openMainModule()
}

class LoginRouter: LoginRouterProtocol {
    
    weak var viewController: LoginViewController?
    
    func openAuthModule() {
        let vc = AuthAssembly.authBiuld()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMainModule() {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        viewController?.navigationController?.pushViewController(vc, animated: false)
    }
}
