//
//  NewCardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardInteractorProtocol: AnyObject {
    
}

final class NewCardInteractor: NewCardInteractorProtocol {
    
    weak var presenter: NewCardPresenterProtocol?
    
    private func validateTextForDigits(_ text: String) -> Bool {
        let regex = "^[0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
}
