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
    
    //MARK: Public properties
    var presenter: LoginPresenterProtocol?
    
    //MARK: Private properties
    private lazy var animationView = LoginAnimationView()
    private lazy var scrollView = UIScrollView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    private lazy var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    
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
        view.backgroundColor = UIColor(named: "backColor")
        createNavBarButtons()
        createAnimationView()
        createScrollView()
        createLoginView()
    }
    func createNavBarButtons() {
        let button = UIButton(systemImage: "link.icloud.fill", color: .white)
        button.addTarget(self, action: #selector(goToWebsiteAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    func createAnimationView() {
        animationView.backgroundColor = UIColor(named: "frontColor")
        view.insertSubview(animationView, at: 0)
        animationView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height / 2.5)
        }
    }
    func createScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        view.insertSubview(scrollView, at: 1)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createLoginView() {
        //loginView.backgroundColor = .systemBackground
        loginView.backgroundColor = .black
        loginView.radiusAndShadow(radius: 30)
        scrollView.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.center.equalTo(scrollView.snp.center)
            make.left.equalTo(scrollView.snp.left).inset(20)
            make.right.equalTo(scrollView.snp.right).inset(20)
            make.height.equalTo(scrollView.frame.height / 3)
        }
        loginView.faceIDButton.addTarget(self, action: #selector(userDidTapFaceID), for: .touchUpInside)
        loginView.loginButt.addTarget(self, action: #selector(userDidTapLogin), for: .touchUpInside)
        loginView.nameField.delegate = self
        loginView.passField.delegate = self
        resizeViews()
    }
    func resizeViews() {
        animationView.animationView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height / 4)
        }
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
        loginView.nameField.resignFirstResponder()
        loginView.passField.resignFirstResponder()
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
