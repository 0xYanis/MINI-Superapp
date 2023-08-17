//
//  NewCardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func userSetBank(_ text: String)
    func userSetNumber(_ text: String)
    func userSetCVV(_ text: String)
}

final class NewCardInteractor: NewCardInteractorProtocol {
    weak var presenter: NewCardPresenterProtocol?
    
    private lazy var bankName: String = ""
    private lazy var cardNumber: String = ""
    private lazy var cvvNumber: String = ""
    
    func viewDidLoaded() {
        
    }
    
    func userSetBank(_ text: String) {
        guard text.count >= 3 else { return }
        self.bankName = text
    }
    
    func userSetNumber(_ text: String) {
        guard validateTextForDigits(text) else { return }
        guard (16...20).contains(text.count) else { return }
        self.cardNumber = text
    }
    
    func userSetCVV(_ text: String) {
        guard validateTextForDigits(text) else { return }
        guard text.count == 3 else { return }
        self.cvvNumber = text
    }
    
    private func validateTextForDigits(_ text: String) -> Bool {
        let regex = "^[0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
}
