//
//  ProfileViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import UIKit

// MARK: - ProfileViewProtocol

protocol ProfileViewProtocol: AnyObject {
    func updateView()
    func showAlert()
}

final class ProfileViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var presenter: ProfilePresenterProtocol?
    
    // MARK: - Private properties
    
    private let tableView = ProfileTableView()
    private lazy var photoPicker = UIImagePickerController()
    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(
            title: "logout_alert_title".localized,
            message: "logout_alert_message".localized,
            preferredStyle: .alert
        )
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        return alert
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    
    func updateView() {
        tableView.reloadData()
    }
    
    func showAlert() {
        present(alert, animated: true)
    }
    
}

// MARK: - Private methods

private extension ProfileViewController {
    
    func initialize() {
        photoPicker.delegate = self
        view.backgroundColor = .back2MINI
        createNavigation(title: "profile_navbar".localized)
        createTableView()
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = changeButton
    }
    
    var logoutButton: UIBarButtonItem {
        return UIBarButtonItem(
            title: "logout_button".localized,
            style: .plain,
            target: self,
            action: #selector(logoutButtonAction)
        )
    }
    
    var changeButton: UIBarButtonItem {
        return UIBarButtonItem(
            title: "Изм.",
            style: .plain,
            target: self,
            action: #selector(showPhotoPicker)
        )
    }
    
    func createTableView() {
        tableView.presenter = presenter
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
}

// MARK: - Private alert actions

private extension ProfileViewController {
    
    @objc func logoutButtonAction() {
        present(alert, animated: true)
    }
    
    var cancelAction: UIAlertAction {
        return UIAlertAction(
            title: "logout_alert_cancel".localized,
            style: .cancel
        )
    }
    
    var logoutAction: UIAlertAction {
        return UIAlertAction(
            title: "logout_alert_logout".localized,
            style: .destructive
        ) { [weak self] _ in
            self?.presenter?.userWantToLogout()
        }
    }
    
    @objc func showPhotoPicker() {
        guard let sheet = photoPicker.sheetPresentationController else { return }
        photoPicker.isModalInPresentation = true
        sheet.detents = [.medium(), .large()]
        sheet.preferredCornerRadius = 30
        present(photoPicker, animated: true)
    }
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        let originalImage = UIImagePickerController.InfoKey.originalImage
        guard let newImage = info[originalImage] as? UIImage else { return }
        guard let imageData = newImage.jpegData(compressionQuality: 0.4) else { return }
        presenter?.userSetAvatar(imageData)
    }
}
