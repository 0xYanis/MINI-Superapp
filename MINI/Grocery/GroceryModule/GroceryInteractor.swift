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
    var adressesData: [String] { get }
    
    func viewDidLoaded()
    func userStartSearchAdress(with searchText: String)
}

final class GroceryInteractor: GroceryInteractorProtocol {
    
    weak var presenter: GroceryPresenterProtocol?
    var groceryService: GroceryServiceProtocol
    var locationService: LocationServiceProtocol
    
    var groceryData: [[GroceryEntity]] = []
    var filteredData: [[GroceryEntity]] = []
    var adressesData: [String] = []
    
    init(
        groceryService: GroceryServiceProtocol,
        locationService: LocationServiceProtocol = LocationService()
    ) {
        self.groceryService = groceryService
        self.locationService = locationService
    }
    
    
    func viewDidLoaded() {
        getGroceries()
    }
    
    func userStartSearchAdress(with searchText: String) {
        adressesData.removeAll()
        DispatchQueue.global().async {
            self.getPlacemarks(with: searchText) { [weak self] addresses in
                self?.adressesData = addresses
            }
        }
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
    
    func getPlacemarks(with address: String, completion: @escaping ([String]) -> Void) {
        let city = UserDefaults.standard.string(forKey: "city") ?? "Moscow"
        locationService.getPlacemarksByAddress(address, city: city) { adresses in
            guard let adresses = adresses else { return }
            completion(adresses)
        }
    }
    
}
