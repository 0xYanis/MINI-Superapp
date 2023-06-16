//
//  CategoryInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import Foundation

protocol CategoryInteractorProtocol: AnyObject {
    func viewDidLoaded()
    
    func userAddProductToCart(_ section: Int,_ index: Int)
}

final class CategoryInteractor: CategoryInteractorProtocol {
    
    weak var presenter: CategoryPresenterProtocol?
    
    private var totalCost: Double = 0.0
    
    func viewDidLoaded() {
        
        presenter?.updateView()
    }
    
    func userAddProductToCart(_ section: Int, _ index: Int) {
        
        // logic
        
        presenter?.updateCart(with: totalCost)
    }
}
