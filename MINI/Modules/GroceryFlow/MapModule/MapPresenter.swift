//
//  MapPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import MapKit

protocol MapPresenterProtocol: AnyObject {
    func viewDidAppear()
    func searchAdress(with text: String, region: MKCoordinateRegion)
    func didTapResult(with index: Int)
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var fbFirestoreManager: FBFirestoreProtocol?
    
    private var localSearch: LocalSearchService
    private var addressList: [LocalSearchResult] = []
    
    init(view: MapViewProtocol) {
        self.view = view
        localSearch = LocalSearchServiceImpl()
        localSearch.output = self
    }
    
    func viewDidAppear() {
        LocationService.shared.request()
    }
    
    public func searchAdress(with text: String, region: MKCoordinateRegion) {
        localSearch.searchLocations(localRegion: region, query: text)
    }
    
    public func didTapResult(with index: Int) {
        
    }
    
    private func setAddress(_ address: String) {
        // save to DB
    }
    
}

extension MapPresenter: LocalSearchOutput {
    
    func didUpdateResults(_ results: [LocalSearchResult]) {
        self.addressList = results
        view?.setResults(results)
    }
    
    func didFailWithError(_ error: Error) {
        view?.showError(message: error.localizedDescription)
    }
    
}
