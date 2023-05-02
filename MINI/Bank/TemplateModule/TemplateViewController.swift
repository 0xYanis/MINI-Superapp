//
//  TemplateViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 28.04.2023.
//

import UIKit

protocol TemplateViewProtocol: AnyObject {
    
}

final class TemplateViewController: UIViewController {
    
    var presenter: TemplatePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension TemplateViewController: TemplateViewProtocol {
    
}

private extension TemplateViewController {
    func initialize() {
        
    }
}
