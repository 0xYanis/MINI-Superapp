//
//  GroceryInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import Foundation

protocol GroceryInteractorProtocol: AnyObject {
    var groceryData: [[GroceryEntity]] { get }
    var filteredData: [[GroceryEntity]] { get }
    
    func viewDidLoaded()
    func userStartSearchAdress(with searchText: String)
    func userDidTapLocation(at index: Int)
}

final class GroceryInteractor: GroceryInteractorProtocol {
    
    weak var presenter: GroceryPresenterProtocol?
    
    var groceryService: GroceryServiceProtocol
    var fbFirestoreManager: FBFirestoreProtocol
    
    var groceryData: [[GroceryEntity]] = []
    var filteredData: [[GroceryEntity]] = []
    
    init(
        groceryService: GroceryServiceProtocol,
        fbFirestoreManager: FBFirestoreProtocol
    ) {
        self.groceryService = groceryService
        self.fbFirestoreManager = fbFirestoreManager
    }
    
    
    func viewDidLoaded() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.getGroceries()
            
        }
    }
    
    func userStartSearchAdress(with searchText: String) {
        
    }
    
    func userDidTapLocation(at index: Int) {
        
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
                let message = error.localizedDescription
                self.presenter?.loadingDataGetFailed(with: message)
            }
        }
    }
    
    func setAddress(_ address: String) {
        let uid = UserDefaults.standard.string(forKey: "uid")
        DispatchQueue.global().async {
            self.fbFirestoreManager.updateUserData(
                uid: uid,
                updatedData: ["address": address])
        }
    }
    
}
