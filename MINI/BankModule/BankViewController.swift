//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit

protocol BankViewProtocol: AnyObject {
    
}

final class BankViewController: UIViewController {
    
    var presenter: BankPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension BankViewController: BankViewProtocol {
    
}

private extension BankViewController {
    func initialize() {
        view.backgroundColor = .white
    }
}
