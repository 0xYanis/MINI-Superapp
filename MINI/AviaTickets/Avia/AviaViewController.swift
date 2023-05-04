//
//  AviaViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import UIKit
import SnapKit

protocol AviaViewProtocol: AnyObject {
    
}

final class AviaViewController: UIViewController {
    
    //MARK: - Private properties
    
    
    //MARK: - Public properties
    var presenter: AviaPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARK: - AviaViewProtocol
extension AviaViewController: AviaViewProtocol {
    
}

//MARK: - Private methods
private extension AviaViewController {
    func initialize() {
        
    }
    
}
