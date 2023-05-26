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
        createNavigation(title: "Profile")
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = createLogoutButton
    }
    
    var createLogoutButton: UIBarButtonItem {
        return UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutButtonAction)
        )
    }
}

private extension ProfileViewController {
    @objc func logoutButtonAction() {
        let alert = UIAlertController(
            title: "Caution!",
            message: "Are You sure, You want to logout?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let logout = UIAlertAction(title: "Logout!", style: .destructive) { [weak self] _ in
            self?.presenter?.userWantToLogout()
        }
        alert.addAction(logout)
        
        present(alert, animated: true, completion: nil)
    }
}
