//
//  SupportViewContoller.swift
//  MINI
//
//  Created by Yan Rybkin on 23.08.2023.
//

import UIKit

protocol SupportViewProtocol: AnyObject {
    func updateView()
    func loadingDataGetFailed(with message: String)
}

final class SupportViewContoller: UIViewController {
    
    var presenter: SupportPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

extension SupportViewContoller: SupportViewProtocol {
    
    func updateView() {
        
    }
    
    func loadingDataGetFailed(with message: String) {
        
    }
    
}

private extension SupportViewContoller {
    
    func initialize() {
        
    }
    
}
