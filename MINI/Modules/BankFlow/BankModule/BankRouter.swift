//
//  BankRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation
import UIKit

protocol BankRouterProtocol: AnyObject {
    func goToDetailCard(with data: Card)
    func goToDetailTemplate(id: Int)
    func goToAllTemplates(with data: [Template])
    func goToDetailTransaction(with data: Transaction)
    func goToAddNewCard()
    func goToAddNewTemplate()
}

final class BankRouter: BankRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailCard(with data: Card) {
        let cardView = CardBuilder.build(with: data.id)
        view?.navigationController?.push(cardView)
    }
    
    func goToDetailTemplate(id: Int) {
        let templateView = TemplateBuilder.build()
        view?.navigationController?.push(templateView)
    }
    
    func goToAllTemplates(with data: [Template]) {
        let allTemplatesView = AllTemplatesBuilder.build(with: data)
        view?.navigationController?.push(allTemplatesView)
    }
    
    func goToDetailTransaction(with data: Transaction) {
        let transactionView = TransactionBuilder.build(with: data)
        view?.navigationController?.push(transactionView)
    }
    
    func goToAddNewCard() {
        let newCard = NewCardBuilder.build()
        view?.navigationController?.push(newCard)
    }
    
    func goToAddNewTemplate() {
        let newTemplate = NewTemplateBuilder.build()
        view?.navigationController?.push(newTemplate)
    }

}
