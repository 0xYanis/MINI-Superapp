//
//  NewCardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func enterText(_ text: String, fieldId: Int)
    func addCard()
}

final class NewCardInteractor: NewCardInteractorProtocol {
    
    weak var presenter: NewCardPresenterProtocol?
    
    private var repository: CardRepository
    private var formFields: [FormTableView.FormField] = [
        .init(title: "Название банка", placeholder: "Например 'МИНИБАНК'"),
        .init(title: "Номер карты", placeholder: "1111 2222 3333 4444"),
        .init(title: "Имя держателя карты", placeholder: "IVAN IVANOV"),
        .init(title: "cvv", placeholder: "111", isSecure: true)
    ]
    
    private var isCorrect: Bool = false {
        didSet {
            presenter?.updateView(dataIsCorrect: isCorrect)
        }
    }
    
    init() {
        self.repository = CardRepository()
    }
    
    func viewDidLoaded() {
        presenter?.setFormTextFields(formFields)
    }
    
    func enterText(_ text: String, fieldId: Int) {
        // Можно добавить сообщение об ошибке
        guard isValid(text, fieldId: fieldId) else {
            formFields[fieldId].text = ""
            print("DEBUG: валидация провалена");
            return
        }
        print("DEBUG: валидация успешно пройдена")
        formFields[fieldId].text = text
        
        self.isCorrect = formFields.allSatisfy { !$0.text.isEmpty }
        print("DEBUG: isCorrect = \(isCorrect)")
    }
    
    private func isValid(_ text: String, fieldId: Int) -> Bool {
        switch fieldId {
        case 0: return text.isOnlyLetters
        case 1: return text.isOnlyNumbers && (16...20).contains(text.count)
        case 2: return text.isOnlyLetters
        case 3: return text.isOnlyNumbers && text.count == 3
        default: return false
        }
    }
    
    func addCard() {
        let fields = formFields.map { $0.text }
        let card = Card(
            bank: fields[0],
            number: fields[1],
            holderName: fields[2],
            cvv: fields[3]
        )
        try? repository.addCard(card)
    }
    
}
