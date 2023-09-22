//
//  CartRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import UIKit

protocol CartRouterProtocol: AnyObject {
	func goToBuyView()
}

final class CartRouter: CartRouterProtocol {
	
	weak var view: UIViewController?
    
    public func goToBuyView() {
        let paymentView = UIViewController()
        paymentView.view.backgroundColor = .gray
        view?.present(paymentView, animated: true)
    }
	
}
