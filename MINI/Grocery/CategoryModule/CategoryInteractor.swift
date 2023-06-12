//
//  CategoryInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import Foundation

protocol CategoryInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class CategoryInteractor: CategoryInteractorProtocol {
    
    weak var presenter: CategoryPresenterProtocol?
    
    func viewDidLoaded() {
        
        presenter?.updateView()
    }
    
    
}
