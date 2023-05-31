//
//  BankRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation
import UIKit

protocol BankRouterProtocol: AnyObject {
    func goToDetailCard(with data: BankCardEntity)
    func goToDetailTemplate(id: Int)
    func goToAllTemplates(with data: [BankTemplateEntity])
    func goToDetailTransaction(id: Int)
    func goToAddNewCard()
    func goToAddNewTemplate()
}

final class BankRouter: BankRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailCard(with data: BankCardEntity) {
        let cardView = CardBuilder.build(with: data)
        view?.navigationController?.pushViewController(cardView, animated: true)
    }
    
    func goToDetailTemplate(id: Int) {
        let templateView = TemplateBuilder.build()
        view?.navigationController?.pushViewController(templateView, animated: true)
    }
    
    func goToAllTemplates(with data: [BankTemplateEntity]) {
        let allTemplatesView = AllTemplatesBuilder.build(with: data)
        view?.navigationController?.pushViewController(allTemplatesView, animated: true)
    }
    
    func goToDetailTransaction(id: Int) {
        let transactionView = TransactionBuilder.build()
        view?.navigationController?.pushViewController(transactionView, animated: true)
    }
    
    func goToAddNewCard() {
        let newCard = NewCardBuilder.build()
        view?.navigationController?.pushViewController(newCard, animated: true)
    }
    
    func goToAddNewTemplate() {
        let newTemplate = NewTemplateBuilder.build()
        view?.navigationController?.pushViewController(newTemplate, animated: true)
    }
    
}
