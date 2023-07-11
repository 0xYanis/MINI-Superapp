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
        
        let isEmpty = false
        presenter?.hideCart(cart: isEmpty)
    }
    
}

private extension CartInteractor {
    
}
