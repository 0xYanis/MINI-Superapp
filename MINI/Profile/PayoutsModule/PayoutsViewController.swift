//
//  PayoutsViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import UIKit
import SnapKit

protocol PayoutsViewProtocol: AnyObject {
    
}

final class PayoutsViewController: UIViewController {
    
    var presenter: PayoutsPresenterProtocol?
    
    private lazy var emptyView = EmptyPayoutsView()
    private lazy var payoutsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
}

extension PayoutsViewController: PayoutsViewProtocol {
    
}
