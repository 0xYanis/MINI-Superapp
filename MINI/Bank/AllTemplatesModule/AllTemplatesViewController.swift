//
//  AllTemplatesViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit

protocol AllTemplatesViewProtocol: AnyObject {
    func userWantToDeleteTemplate(id: Int)
}

final class AllTemplatesViewController: UIViewController {
    var presenter: AllTemplatesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension AllTemplatesViewController: AllTemplatesViewProtocol {
    func userWantToDeleteTemplate(id: Int) {
        presenter?.userWillDeleteTemplate(id: id)
    }
}

private extension AllTemplatesViewController {
    func initialize() {
        view.backgroundColor = .white
    }
}
