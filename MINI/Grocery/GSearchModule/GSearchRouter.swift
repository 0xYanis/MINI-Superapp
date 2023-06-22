//
//  GSearchRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 22.06.2023.
//

import UIKit

protocol GSearchRouterProtocol: AnyObject {
    func goToDetaiProduct()
}

final class GSearchRouter: GSearchRouterProtocol {
    weak var view: UIViewController?
    
    func goToDetaiProduct() {
        let detailProduct = ProductBuilder.build()
        view?.navigationController?.pushViewController(
            detailProduct,
            animated: true
        )
    }
}
