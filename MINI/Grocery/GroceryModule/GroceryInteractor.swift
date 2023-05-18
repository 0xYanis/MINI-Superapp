//
//  GroceryInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import Foundation

protocol GroceryInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func getGroceryData() -> [[GroceryEntity]]
}

final class GroceryInteractor: GroceryInteractorProtocol {
    
    weak var presenter: GroceryPresenterProtocol?
    var groceryService: GroceryServiceProtocol
    
    private var groceryData: [[GroceryEntity]] = []
    
    init(
        groceryService: GroceryServiceProtocol
    ) {
        self.groceryService = groceryService
    }
    
    
    func viewDidLoaded() {
        getGroceries()
    }
    
    func getGroceryData() -> [[GroceryEntity]] {
        return groceryData
    }
}

private extension GroceryInteractor {
    func getGroceries() {
        groceryService.getGroceryData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let groceries):
                self.groceryData = groceries ?? []
            case .failure(let error):
                self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
            }
        }
    }
}
