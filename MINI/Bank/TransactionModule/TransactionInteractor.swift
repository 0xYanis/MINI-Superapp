//
//  TransactionInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol TransactionInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func userWillRemoveTransaction(id: Int)
    
}

final class TransactionInteractor: TransactionInteractorProtocol {
    weak var presenter: TransactionPresenterProtocol?
    
    func viewDidLoaded() {
        ///
    }
    
    func userWillRemoveTransaction(id: Int) {
        ///
    }
}
