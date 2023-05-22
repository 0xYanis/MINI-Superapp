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
    }
}
