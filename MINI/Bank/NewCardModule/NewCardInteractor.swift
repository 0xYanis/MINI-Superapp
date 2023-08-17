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
    
    func viewDidLoaded() {
        
    }
    
    func userSetBank(_ text: String) {
        
    }
    
    func userSetNumber(_ text: String) {
        
    }
    
    func userSetCVV(_ text: String) {
        
    }
    
}
