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
    var locations: [Location] { get }
    
    
    func viewDidLoaded()
    func userStartSearchAdress(with searchText: String)
    func userDidTapLocation(at index: Int)
}

final class GroceryInteractor: GroceryInteractorProtocol {
    
    weak var presenter: GroceryPresenterProtocol?
    var groceryService: GroceryServiceProtocol
    var locationService: LocationServiceProtocol
    
    var groceryData: [[GroceryEntity]] = []
    var filteredData: [[GroceryEntity]] = []
    var locations: [Location] = []
    
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
        locationService.findLocations(with: searchText) { [weak self] locations in
            guard let self = self else { return }
            self.locations = locations
        }
    }
    
    func userDidTapLocation(at index: Int) {
        if locations.isEmpty == false {
            let coordinate = locations[index].coordinate
            print(coordinate)
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
                let message = error.localizedDescription
                self.presenter?.loadingDataGetFailed(with: message)
            }
        }
    }
    
}
