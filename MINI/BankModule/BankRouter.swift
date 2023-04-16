//
//  BankRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation
import UIKit

protocol BankRouterProtocol: AnyObject {
    func goToDetailCard(id: Int)
    func goToDetailTransaction(id: Int)
    func didAddNewCard()
    func didAddNewTransaction()
}

final class BankRouter: BankRouterProtocol {
    
    weak var view: BankViewController?
    
    func goToDetailCard(id: Int) {
        let cardView = UIViewController()
        cardView.view.backgroundColor = .white
        view?.navigationController?.pushViewController(cardView, animated: true)
    }
    
    func goToDetailTransaction(id: Int) {
        let transactionView = UIViewController()
        transactionView.view.backgroundColor = .white
        view?.navigationController?.pushViewController(transactionView, animated: true)
    }
    
    func didAddNewCard() {
        
    }
    
    func didAddNewTransaction() {
        
    }
    
}
