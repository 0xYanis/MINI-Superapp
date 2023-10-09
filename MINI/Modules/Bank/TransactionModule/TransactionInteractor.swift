//
//  TransactionInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol TransactionInteractorProtocol: AnyObject {
    var dataSource: TransactionEntity { get }
    func viewDidLoaded()
    func userWillRemoveTransaction(id: Int)
}

final class TransactionInteractor: TransactionInteractorProtocol {
    
    //MARK: - Public properties
    
    weak var presenter: TransactionPresenterProtocol?
    public var dataSource: TransactionEntity = .init()
    
    //MARK: - Private properties
    
    private var transactionData: Transaction?
    
    //MARK: - Lifecycle
    
    init(data: Transaction) {
        self.transactionData = data
    }
    
    //MARK: - Public methods
    
    public func viewDidLoaded() {
        entityMapper()
    }
    
    public func userWillRemoveTransaction(id: Int) {
        ///
    }
    
    //MARK: - Private methods
    
    private func entityMapper() {
        guard let data = transactionData else { return }
        self.dataSource = TransactionEntity()
        dataSource.image = data.icon ?? ""
        dataSource.navTitle = data.name
        
        _ = data.mapToTableDatasource().map { key, value in
            if let key = key,
               let value = value {
                dataSource.title.append(key)
                dataSource.label.append(value)
            }
        }
        
        presenter?.updateView(with: dataSource)
    }
    
}

struct TransactionEntity {
    var navTitle: String = ""
    var image: String = ""
    var title: [String] = []
    var label: [String] = []
}
