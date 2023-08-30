//
//  CartInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import Foundation

protocol CartInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class CartInteractor: CartInteractorProtocol {
    weak var presenter: CartPresenterProtocol?
    
    func viewDidLoaded() {
        // logic
        
    }
    
}

private extension CartInteractor {
    
}
