//
//  NewCardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class NewCardInteractor: NewCardInteractorProtocol {
    weak var presenter: NewCardPresenterProtocol?
    
    func viewDidLoaded() {
        
    }
}
