//
//  LoginViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit
import SnapKit

protocol LoginViewProtocol: AnyObject {
    func showAlert(_ title: String, message: String)
}

final class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private let animationView = LoginAnimationView()
    private let loginView = LoginView()
    private var isLoginViewExpanded = true
}

extension LoginViewController: LoginViewProtocol {
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController()
        alert.showAlert(title: title, message: message, from: self)
    }
}

private extension LoginViewController {
    func initialize() {
        view.backgroundColor = .white
        createNavBarButtons()
        createAnimationView()
        createLoginView()
    }
    func createNavBarButtons() {
        let image = UIImage(systemName: "link.icloud.fill")
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    @objc func buttonAction() {
        if let url = URL(string: "https://github.com/0xYanis") {
            UIApplication.shared.open(url)
        }
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
        loginView.backgroundColor = .white
        loginView.radiusAndShadow(radius: 30)
        view.insertSubview(loginView, at: 1)
        loginView.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).inset(view.frame.height / 9)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.frame.height / 2.2)
        }
    }
    func textFieldPressed() {
        isLoginViewExpanded.toggle()
        resizeLoginView(isExpanded: isLoginViewExpanded)
    }
    func resizeLoginView(isExpanded: Bool) {
        let newHeight: CGFloat = isExpanded ? view.frame.height / 2.2 : view.frame.height / 3
        UIView.animate(withDuration: 0.3) {
            self.loginView.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }
            self.view.layoutIfNeeded()
        }
    }
}
