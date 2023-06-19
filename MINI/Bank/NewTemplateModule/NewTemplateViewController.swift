//
//  NewTemplateViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 25.04.2023.
//

import UIKit

protocol NewTemplateViewProtocol: AnyObject {
    
}

final class NewTemplateViewController: UIViewController {
    var presenter: NewTemplatePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

extension NewTemplateViewController: NewTemplateViewProtocol {
    
}

private extension NewTemplateViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "add_new_template_title".localized
    }
}

