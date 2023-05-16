//
//  GroceryInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import Foundation

protocol GroceryInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class GroceryInteractor: GroceryInteractorProtocol {
    weak var presenter: GroceryPresenterProtocol?
    
    func viewDidLoaded() {
        
    }
}

private extension GroceryInteractor {
    
}
