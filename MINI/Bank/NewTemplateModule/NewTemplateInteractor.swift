//
//  NewTemplateInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 25.04.2023.
//

import Foundation

protocol NewTemplateInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class NewTemplateInteractor: NewTemplateInteractorProtocol {
    weak var presenter: NewTemplatePresenterProtocol?
    
    func viewDidLoaded() {
        
    }
}
