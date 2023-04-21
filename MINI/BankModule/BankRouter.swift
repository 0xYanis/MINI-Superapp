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
    func goToDetailTemplate(id: Int)
    func goToAllTemplates()
    func goToDetailTransaction(id: Int)
    func didAddNewCard()
    func didAddNewTransaction()
}

final class BankRouter: BankRouterProtocol {
    
    weak var view: BankViewController?
    
    func goToDetailCard(id: Int) {
        let cardView = UIViewController()
        cardView.view.backgroundColor = .green
        view?.navigationController?.pushViewController(cardView, animated: true)
    }
    
    func goToDetailTemplate(id: Int) {
        let templateView = UIViewController()
        templateView.view.backgroundColor = .blue
        view?.navigationController?.pushViewController(templateView, animated: true)
    }
    
    func goToAllTemplates() {
        let allTemplatesView = UIViewController()
        allTemplatesView.view.backgroundColor = .systemPink
        view?.navigationController?.pushViewController(allTemplatesView, animated: true)
    }
    
    func goToDetailTransaction(id: Int) {
        let transactionView = UIViewController()
        transactionView.view.backgroundColor = .systemOrange
        view?.navigationController?.pushViewController(transactionView, animated: true)
    }
    
    func didAddNewCard() {
        
    }
    
    func didAddNewTransaction() {
        
    }
    
}
