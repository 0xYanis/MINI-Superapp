//
//  RegisterViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit
import SnapKit

protocol RegisterViewProtocol: AnyObject {
    func registerIsNotCorrect(with message: String)
}

final class RegisterViewController: UIViewController {
    
    var presenter: RegisterPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

extension RegisterViewController: RegisterViewProtocol {
    func registerIsNotCorrect(with message: String) {
        let title = "Ошибка"
        let alert = UIAlertController()
        alert.showAlert(title: title, message: message, from: self)
    }
}

private extension RegisterViewController {
    func initialize() {
        view.backgroundColor = .quaternarySystemFill
    }
}
