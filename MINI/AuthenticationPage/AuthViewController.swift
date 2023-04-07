//
//  AuthViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 08.04.2023.
//

import UIKit

protocol AuthViewControllerProtocol: AnyObject {
    
}

class AuthViewController: UIViewController {
    
    var presenter: AuthPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AuthViewController: AuthViewControllerProtocol {
    
}
