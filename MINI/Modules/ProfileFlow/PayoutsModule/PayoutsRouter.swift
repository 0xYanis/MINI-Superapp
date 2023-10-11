//
//  PayoutsRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import UIKit

protocol PayoutsRouterProtocol: AnyObject {
    func goTo(_ type: PayoutsType, with index: Int)
}

final class PayoutsRouter: PayoutsRouterProtocol {
    
    weak var view: UIViewController?
    
    func goTo(_ type: PayoutsType, with index: Int) {
        let def = UIViewController()
        def.view.backgroundColor = .white
        
        switch type {
        case .favorites: push(to: def)
        case .transactions: push(to: def)
        case .orders: push(to: def)
        case .tickets: push(to: def)
        }
    }
    
    private func push(to vc: UIViewController) {
        view?.navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
    
}
