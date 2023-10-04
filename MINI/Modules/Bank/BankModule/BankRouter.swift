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
    func goToDetailTransaction(with data: BankTransactionEntity)
    func goToAddNewCard()
    func goToAddNewTemplate()
}

final class BankRouter: BankRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToDetailCard(with data: BankCardEntity) {
        let cardView = CardBuilder.build(with: data)
        push(to: cardView)
    }
    
    func goToDetailTemplate(id: Int) {
        let templateView = TemplateBuilder.build()
        push(to: templateView)
    }
    
    func goToAllTemplates(with data: [BankTemplateEntity]) {
        let allTemplatesView = AllTemplatesBuilder.build(with: data)
        push(to: allTemplatesView)
    }
    
    func goToDetailTransaction(with data: BankTransactionEntity) {
        let transactionView = TransactionBuilder.build(with: data)
        push(to: transactionView)
    }
    
    func goToAddNewCard() {
        let newCard = NewCardBuilder.build()
        push(to: newCard)
    }
    
    func goToAddNewTemplate() {
        let newTemplate = NewTemplateBuilder.build()
        push(to: newTemplate)
    }
    
    private func push(to vc: UIViewController) {
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
