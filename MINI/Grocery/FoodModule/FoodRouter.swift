//
//  FoodRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit

protocol FoodRouterProtocol: AnyObject {
    func goToDetailProduct()
}

final class FoodRouter: FoodRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailProduct() {
        
    }
}
