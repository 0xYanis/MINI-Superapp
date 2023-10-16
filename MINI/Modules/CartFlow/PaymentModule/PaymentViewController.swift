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
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "Оплата"
        view.backgroundColor = .back2MINI
    }
    
    var doneButton: UIBarButtonItem {
        UIBarButtonItem(
            title: "Отмена",
            style: .done,
            target: self,
            action: #selector(closeViewAction)
        )
    }
    
    @objc func closeViewAction() {
        dismiss(animated: true)
    }
    
}
