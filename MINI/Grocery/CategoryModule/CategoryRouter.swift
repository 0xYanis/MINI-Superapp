//
//  CategoryRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit

protocol CategoryRouterProtocol: AnyObject {
    func goToDetailProduct()
}

final class CategoryRouter: CategoryRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailProduct() {
        
    }
}
