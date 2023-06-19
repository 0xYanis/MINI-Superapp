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
    
    private lazy var generator    = UINotificationFeedbackGenerator()
    private lazy var registerView = RegisterView()
    private lazy var scrollView   = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

extension RegisterViewController: RegisterViewProtocol {
    func registerIsNotCorrect(with message: String) {
        let title = "error_login_title".localized
        let alert = UIAlertController()
        alert.showAlert(title: title, message: message, from: self)
    }
}

private extension RegisterViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
        createScrollView()
        createRegisterView()
        configureRegisterView()
        createTapGesture()
        registerForKeyboardNotifications()
    }
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func createRegisterView() {
        scrollView.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.42)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.center.equalToSuperview()
        }
    }
    
    func configureRegisterView() {
        registerView.regButton.addTarget(
            self,
            action: #selector(userDidTapRegister),
            for: .touchUpInside
        )
        registerView.nameField.delegate = self
        registerView.passField.delegate = self
        registerView.secondPassField.delegate = self
    }
    
    func createTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapOffTheField)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
}

//MARK: - functionality methods
private extension RegisterViewController {
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                                  as? NSValue)?.cgRectValue.size else { return }
        
        scrollView.contentOffset = .init(
            x: 0,
            y: keyboardSize.height / 3
        )
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = .zero
    }
    
    
    @objc func handleTapOffTheField() {
        registerView.nameField.resignFirstResponder()
        registerView.passField.resignFirstResponder()
        registerView.secondPassField.resignFirstResponder()
    }
    
    @objc func userDidTapRegister() {
        let login      = registerView.nameField.text ?? ""
        let pass       = registerView.passField.text ?? ""
        let secondPass = registerView.secondPassField.text ?? ""
        presenter?.userWantToLogin(
            login: login,
            password: pass,
            repeatPassword: secondPass
        )
    }
    
    
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case registerView.nameField:
            registerView.passField.becomeFirstResponder()
            
        case registerView.passField:
            registerView.secondPassField.becomeFirstResponder()
            
        default:
            registerView.secondPassField.resignFirstResponder()
            userDidTapRegister()
        }
        return true
    }
}
