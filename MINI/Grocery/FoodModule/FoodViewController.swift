//
//  FoodViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit
import SnapKit

protocol FoodViewProtocol: AnyObject {
    func udateView()
}

final class FoodViewController: UIViewController {
    
    var presenter: FoodPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    
}

extension FoodViewController: FoodViewProtocol {
    func udateView() {
        
    }
}

private extension FoodViewController {
    func initialize() {
        
    }
}
