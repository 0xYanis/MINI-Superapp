//
//  CardRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardRouterProtocol: AnyObject {
    func goBackToBankView()
}

final class CardRouter: CardRouterProtocol {
    weak var view: CardViewController?
    
    func goBackToBankView() {
        view?.navigationController?.popViewController(animated: true)
    }
}
