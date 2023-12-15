//
//  CardRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

protocol CardRouterProtocol: AnyObject {
    func goBackToBankView()
    func userWantToEditCard()
}

final class CardRouter: CardRouterProtocol {
    
    weak var view: UIViewController?
    
    func goBackToBankView() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func userWantToEditCard() {
        let editView = NewCardBuilder.build()
        view?.navigationController?.push(editView)
    }
    
}
