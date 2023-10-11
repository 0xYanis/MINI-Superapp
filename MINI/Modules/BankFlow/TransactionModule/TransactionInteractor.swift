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
    
    private var transaction: Transaction?
    
    //MARK: - Lifecycle
    
    init(data: Transaction) {
        self.transaction = data
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
        guard let data = transaction else { return }
        self.dataSource = TransactionEntity()
        dataSource.image = data.icon ?? ""
        dataSource.navTitle = data.name
        
        _ = data.mapToDict().map { key, value in
            if let key = key,
               let value = value {
                dataSource.titles.append(key)
                dataSource.labels.append(value)
            }
        }
        
        presenter?.updateView(with: dataSource)
    }
    
}

struct TransactionEntity {
    var navTitle: String = ""
    var image: String = ""
    var titles: [String] = []
    var labels: [String] = []
}
