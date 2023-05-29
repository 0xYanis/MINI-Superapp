//
//  LoginViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit
import SnapKit
import Lottie

protocol LoginViewProtocol: AnyObject {
    func setAnimation(lottie: LottieAnimation)
    func showAlert(_ title: String, message: String)
    
    func loginIsNotCorrect()
}

final class LoginViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: LoginPresenterProtocol?
    
    //MARK: Private properties
    private lazy var generator = UINotificationFeedbackGenerator()
    private lazy var animationView = LoginAnimationView()
    private lazy var loginView = LoginView()
    private lazy var versionLabel = UILabel()
    private lazy var scrollView = UIScrollView(
        frame: .init(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: view.frame.height
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        initialize()
    }
    
    
}

//MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func setAnimation(lottie: LottieAnimation) {
        animationView.animationView = .init(animation: lottie)
        animationView.animationView.play()
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController()
        alert.showAlert(title: title, message: message, from: self)
    }
    
    func loginIsNotCorrect() {
        generator.notificationOccurred(.warning)
    }
}

//MARK: - Private methods
private extension LoginViewController {
    func initialize() {
        generator.prepare()
        createTapGesture()
        createNavBarButtons()
        createAnimationView()
        createScrollView()
        createLoginView()
        configureLoginView()
        registerForKeyboardNotifications()
        createVersionLabel()
    }
    
    func createTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapOffTheField)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    func createNavBarButtons() {
        let button = UIButton(
            systemImage: "link.icloud.fill",
            color: .white
        )
        button.addTarget(
            self,
            action: #selector(goToWebsiteAction),
            for: .touchUpInside
        )
        
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
        view.insertSubview(scrollView, at: 1)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createLoginView() {
        loginView.backgroundColor = .systemBackground
        loginView.radiusAndShadow(radius: 30)
        scrollView.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.33)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.center.equalToSuperview()
        }
    }
    
    func configureLoginView() {
        loginView.faceIDButton.addTarget(
            self,
            action: #selector(userDidTapFaceID),
            for: .touchUpInside
        )
        loginView.loginButt.addTarget(
            self,
            action: #selector(userDidTapLogin),
            for: .touchUpInside
        )
        loginView.nameField.delegate = self
        loginView.passField.delegate = self
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
    
    func createVersionLabel() {
        guard let version = Bundle.main.object(
            forInfoDictionaryKey: "CFBundleShortVersionString"
        ) as? String  else { return }
        
        versionLabel.textColor = .darkGray
        versionLabel.text = "MINI. Version: \(version) Created by 0xYanis"
        versionLabel.font = .systemFont(ofSize: 15)
        versionLabel.textAlignment = .center
        versionLabel.numberOfLines = 2
        
        view.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(140)
        }
    }
    
}

//MARK: - functionality methods
private extension LoginViewController {
    @objc func goToWebsiteAction() {
        if let url = URL(string: "https://github.com/0xYanis") {
            UIApplication.shared.open(url)
        }
    }
    
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
        loginView.nameField.resignFirstResponder()
        loginView.passField.resignFirstResponder()
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
            userDidTapLogin()
        }
        return true
    }
}
