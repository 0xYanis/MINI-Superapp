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
    var locations: [Placemark] { get }
    
    
    func viewDidLoaded()
    func userStartSearchAdress(with searchText: String)
    func userDidTapLocation(at index: Int)
}

final class GroceryInteractor: GroceryInteractorProtocol {
    
    weak var presenter: GroceryPresenterProtocol?
    
    var groceryService: GroceryServiceProtocol
    var locationService: LocationServiceProtocol
    var placemarkService: PlacemarkServiceProtocol
    var fbFirestoreManager: FBFirestoreProtocol
    
    var groceryData: [[GroceryEntity]] = []
    var filteredData: [[GroceryEntity]] = []
    var locations: [Placemark] = []
    
    init(
        groceryService: GroceryServiceProtocol,
        locationService: LocationServiceProtocol,
        placemarkService: PlacemarkServiceProtocol,
        fbFirestoreManager: FBFirestoreProtocol
    ) {
        self.groceryService = groceryService
        self.locationService = locationService
        self.placemarkService = placemarkService
        self.fbFirestoreManager = fbFirestoreManager
    }
    
    
    func viewDidLoaded() {
        getGroceries()
        getUserAddress()
    }
    
    func userStartSearchAdress(with searchText: String) {
        DispatchQueue.global().async {
            self.placemarkService.searchPlace(searchText) { [weak self] locations in
                guard let self = self else { return }
                self.locations = locations
                DispatchQueue.main.async {
                    self.presenter?.updateView()
                }
            }
        }
    }
    
    func userDidTapLocation(at index: Int) {
        if locations.isEmpty == false {
            let location = locations[index].location
            self.setAddress(location)
            DispatchQueue.main.async {
                self.presenter?.updateAddress(location)
            }
        }
    }
    
    private func getUserAddress() {
        let uid = UserDefaults.standard.string(forKey: "uid")
        DispatchQueue.global().async {
            self.fbFirestoreManager.getUserData(uid: uid) { result in
                guard let address = result["address"] as? String
                else { return }
                DispatchQueue.main.async {
                    self.presenter?.updateAddress(address)
                }
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
