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
    
    // MARK: - Public properties
    
    var presenter: RegisterPresenterProtocol?
    
    // MARK: - Private properties
    
    private let generator    = UINotificationFeedbackGenerator()
    private let registerView = RegisterView()
    private let scrollView   = UIScrollView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

// MARK: - RegisterViewProtocol

extension RegisterViewController: RegisterViewProtocol {
    
    func registerIsNotCorrect(with message: String) {
        let title = "error_login_title".localized
        let alert = UIAlertController()
        alert.showAlert(title: title, message: message, from: self)
    }
    
}

// MARK: - RegisterViewDelegate

extension RegisterViewController: RegisterViewDelegate {
    
    func userDidTapRegister(name: String, pass: String, secondPass: String) {
        presenter?.userWantToLogin(login: name, password: pass, repeatPassword: secondPass)
    }
    
}

// MARK: - Private methods

private extension RegisterViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        createScrollView()
        createRegisterView()
        createTapGesture()
        registerForKeyboardNotifications()
    }
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    func createRegisterView() {
        registerView.delegate = self
        scrollView.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.42)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.center.equalToSuperview()
        }
    }
    
    func createTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapOffTheField)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    func registerForKeyboardNotifications() {
        addNotification(UIResponder.keyboardWillShowNotification,
                        selector: #selector(keyboardWillShow))
        addNotification(UIResponder.keyboardWillHideNotification,
                        selector: #selector(keyboardWillHide))
    }
    
}

// MARK: - Action methods

private extension RegisterViewController {
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                                  as? NSValue)?.cgRectValue.size else { return }
        
        scrollView.contentOffset = .init(x: 0, y: keyboardSize.height / 3)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = .zero
    }
    
    
    @objc func handleTapOffTheField() {
        registerView.tapOffTheField()
    }
    
}
