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
    
    //MARK: private properties
    private let animationView = LoginAnimationView()
    private let loginView = LoginView()
}

//MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController()
        alert.showAlert(title: title, message: message, from: self)
    }
}

//MARK: - Private methods
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
        button.addTarget(self, action: #selector(goToWebsiteAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
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
            make.height.equalTo(view.frame.height / 3)
        }
        loginView.faceIDButton.addTarget(self, action: #selector(userDidTapFaceID), for: .touchUpInside)
        loginView.loginButt.addTarget(self, action: #selector(userDidTapLogin), for: .touchUpInside)
        loginView.nameField.delegate = self
        loginView.passField.delegate = self
        resizeLoginView()
    }
    func resizeLoginView() {
        loginView.nameField.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height / 17)
        }
        loginView.passField.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height / 17)
        }
        loginView.loginButt.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height / 17)
        }
    }
    
    //MARK: - functionality methods
    @objc func goToWebsiteAction() {
        if let url = URL(string: "https://github.com/0xYanis") {
            UIApplication.shared.open(url)
        }
    }
    @objc func userDidTapFaceID() {
        presenter?.userDidTapBiometry()
    }
    @objc func userDidTapLogin() {
        let name = loginView.nameField.text ?? ""
        let pass = loginView.passField.text ?? ""
        presenter?.userDidTapLogin(name: name, password: pass)
    }
}

//MARK: - protocol UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginView.nameField:
            loginView.passField.becomeFirstResponder()
        default:
            loginView.passField.resignFirstResponder()
        }
        return true
    }
}
