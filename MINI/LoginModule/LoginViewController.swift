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
    let animationView = UIView()
    let loginView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.userDidTapBiometry()
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
        createAnimationView()
        createLoginView()
    }
    func createAnimationView() {
        animationView.backgroundColor = .systemCyan
        view.insertSubview(animationView, at: 0)
        animationView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height / 3)
        }
    }
    func createLoginView() {
        loginView.roundCorners(radius: 30)
        loginView.backgroundColor = .white
        loginView.shadow(color: .black, opacity: 0.2, radius: 15)
        view.insertSubview(loginView, at: 1)
        loginView.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).inset(view.frame.height / 9)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.frame.height / 2.2)
        }
    }
}
