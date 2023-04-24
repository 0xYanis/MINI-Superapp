//
//  BankInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class BankInteractor: BankInteractorProtocol {
    
    weak var presenter: BankPresenterProtocol?
    
    func viewDidLoaded() {
        
    }
}
