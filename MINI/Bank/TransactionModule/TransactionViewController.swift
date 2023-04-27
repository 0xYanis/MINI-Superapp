//
//  TransactionViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit
import SnapKit

protocol TransactionViewProtocol: AnyObject {
    
}

final class TransactionViewController: UIViewController {
    var presenter: TransactionPresenterProtocol?
}

extension TransactionViewController: TransactionViewProtocol {
    
}

private extension TransactionViewController {
    func initialize() {
        view.backgroundColor = .white
    }
}
