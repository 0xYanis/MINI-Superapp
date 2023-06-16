//
//  ProfileViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func updateView()
}

final class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterProtocol?
    
    private lazy var tableView = ProfileTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func updateView() {
        
    }
    
    
}

private extension ProfileViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation(title: "profile_navbar".localized)
        createTableView()
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = createLogoutButton
    }
    
    var createLogoutButton: UIBarButtonItem {
        return UIBarButtonItem(
            title: "logout_button".localized,
            style: .plain,
            target: self,
            action: #selector(logoutButtonAction)
        )
    }
    
    func createTableView() {
        tableView.presenter = presenter
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private extension ProfileViewController {
    @objc func logoutButtonAction() {
        let alert = UIAlertController(
            title: "logout_alert_title".localized,
            message: "logout_alert_message".localized,
            preferredStyle: .alert
        )
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        
        present(alert, animated: true, completion: nil)
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
    
    
}
