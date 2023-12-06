//
//  MapPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import MapKit

protocol MapPresenterProtocol: AnyObject {
    var addressList: [LocalSearchResult] { get }
    
    func viewDidAppear()
    func searchAdress(with text: String, region: MKCoordinateRegion)
    func didTapResult(with index: Int)
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var fbFirestoreManager: FBFirestoreProtocol?
    
    private var localSearch: LocalSearchService
    var addressList: [LocalSearchResult] = []
    
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
        let resultTitle = addressList[index].title
        let resultSubtitle = addressList[index].subtitle
    }
    
    private func setAddress(_ address: String) {
        
    }
    
}

extension MapPresenter: LocalSearchOutput {
    
    func didUpdateResults(_ results: [LocalSearchResult]) {
        view?.setResults(results)
    }
    
    func didFailWithError(_ error: Error) {
        view?.showError(message: error.localizedDescription)
    }
    
}
