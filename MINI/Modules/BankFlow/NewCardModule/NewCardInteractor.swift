//
//  NewCardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func addCard()
}

final class NewCardInteractor: NewCardInteractorProtocol {
    
    weak var presenter: NewCardPresenterProtocol?
    
    private var repository: CardRepository
    
    private let formFields: [FormTableView.FormField] = [
        .init(title: "Название банка", placeholder: "Например 'МИНИБАНК'"),
        .init(title: "Номер карты", placeholder: "1111 2222 3333 4444"),
        .init(title: "Имя держателя карты", placeholder: "IVAN IVANOV"),
        .init(title: "cvv", placeholder: "111", isSecure: true)
    ]
    
    init() {
        self.repository = CardRepository()
    }
    
    func viewDidLoaded() {
        presenter?.setFormTextFields(formFields)
    }
    
    private func validateTextForDigits(_ text: String) -> Bool {
        let regex = "^[0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
    func addCard() {
        let card = Card.generate()
        try? repository.addCard(card)
    }
    
}
