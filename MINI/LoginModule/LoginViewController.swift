//
//  LoginViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit
import SnapKit

protocol LoginViewProtocol: AnyObject {
    func showAlert(message: String)
}

final class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension LoginViewController: LoginViewProtocol {
    func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "Error", message: message, preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

private extension LoginViewController {
    func initialize() {
        view.backgroundColor = .white
    }
}
