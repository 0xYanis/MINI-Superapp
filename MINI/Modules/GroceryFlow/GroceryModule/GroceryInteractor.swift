//
//  GroceryInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import Foundation

protocol GroceryInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func userStartSearchAdress(with searchText: String)
    func userDidTapLocation(at index: Int)
}

final class GroceryInteractor: GroceryInteractorProtocol {
    
    weak var presenter: GroceryPresenterProtocol?
    
    private var localSearch: LocalSearchService
    private var userDataWorker: UserDataWorker
    private var locationList = [LocalSearchResult]()
    
    init() {
        self.userDataWorker = UserDataWorkerImpl()
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
        
    }
    
    func saveAddress(_ address: String) {
        userDataWorker.saveUserAddress(address)
    }
    
    func getAddres() {
        userDataWorker.getUserAddres { [weak self] address in
            DispatchQueue.main.async {
                self?.presenter?.updateAddress(address)
            }
        }
    }
    
}
