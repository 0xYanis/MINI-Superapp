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
    var groceryData: [[GroceryEntity]] = []
    var filteredData: [[GroceryEntity]] = []
    
    private var groceryService: GroceryServiceProtocol
    private var fbFirestoreManager: FBFirestoreProtocol
    private var localSearch: LocalSearchService
    
    private var locationList = [LocalSearchResult]()
    
    init(
        groceryService: GroceryServiceProtocol,
        fbFirestoreManager: FBFirestoreProtocol
    ) {
        self.groceryService = GroceryService()
        self.fbFirestoreManager = FBFirestoreManager()
        self.localSearch = LocalSearchServiceImpl()
        localSearch.output = self
    }
    
    
    func viewDidLoaded() {
        LocationService.shared.request()
        DispatchQueue.global(qos: .userInitiated).async {
            self.getGroceries()
            self.getAddres()
        }
    }
    
    func userStartSearchAdress(with searchText: String) {
        localSearch.searchLocations(localRegion: .init(), query: searchText)
    }
    
    func userDidTapLocation(at index: Int) {
        let location = locationList[index].title + ", " + locationList[index].subtitle
        saveAddress(location)
        presenter?.updateAddress(locationList[index].title)
        getAddres()
    }
    
}

extension GroceryInteractor: LocalSearchOutput {
    
    func didUpdateResults(_ results: [LocalSearchResult]) {
        locationList = results
        presenter?.didUpdateResults(results)
    }
    
    func didFailWithError(_ error: Error) {
        presenter?.loadingDataGetFailed(with: error.localizedDescription)
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
    
    func saveAddress(_ address: String) {
        let uid = UserDefaults.standard.string(forKey: "uid")
        DispatchQueue.global().async {
            self.fbFirestoreManager.updateUserData(
                uid: uid,
                updatedData: ["address": address])
        }
    }
    
    func getAddres() {
        let uid = UserDefaults.standard.string(forKey: "uid")
        self.fbFirestoreManager.getUserData(uid: uid) { result in
            guard let address = result["address"] as? String
            else { return }
            DispatchQueue.main.async {
                self.presenter?.updateAddress(address)
            }
        }
    }
    
}
