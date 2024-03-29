//
//  TransactionPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol TransactionPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func userWantRemoveTransaction(id: Int)
    
    func updateView(with data: TransactionEntity)
}

final class TransactionPresenter {
    weak var view: TransactionViewProtocol?
    
    private var router: TransactionRouterProtocol
    private var interactor: TransactionInteractorProtocol
    
    init(router: TransactionRouterProtocol, interactor: TransactionInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension TransactionPresenter: TransactionPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func userWantRemoveTransaction(id: Int) {
        interactor.userWillRemoveTransaction(id: id)
    }
    
    func updateView(with data: TransactionEntity) {
        view?.updateView(with: data)
    }
    
}
