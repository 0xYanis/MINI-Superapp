//
//  PasswordViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 08.08.2023.
//

import UIKit

protocol PasswordViewProtocol: AnyObject {
    
}

final class PasswordViewController: UIViewController {
    
    var presenter: PasswordPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

extension PasswordViewController: PasswordViewProtocol {
    
}

private extension PasswordViewController {
    
    func initialize() {
        
    }
    
}
