//
//  PaymentViewController.swift
//  MINI
//
//  Created by Yanis on 16.10.2023.
//

import UIKit

protocol PaymentViewProtocol: AnyObject {
    
}

final class PaymentViewController: UIViewController {
    
    var presenter: PaymentPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

extension PaymentViewController: PaymentViewProtocol {
    
}

// MARK: - Private methods & computed properties

private extension PaymentViewController {
    
    func initialize() {
        
    }
    
}

