//
//  MapPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    var searchResults: [Location] { get }
    
    func searchAdress(with text: String)
    func didTapResult(with index: Int)
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var locationService: LocationServiceProtocol?
    
    public var searchResults: [Location] = []
    
    init(view: MapViewProtocol) {
        self.view = view
    }
    
    public func searchAdress(with text: String) {
        DispatchQueue.global().async {
            self.locationService?.findLocations(with: text) { [weak self] locations in
                guard let self = self else { return }
                self.searchResults = locations
                DispatchQueue.main.async {
                    self.view?.updateView()
                }
            }
        }
    }
    
    public func didTapResult(with index: Int) {
        let coordinate = searchResults[index].coordinate
        view?.setPin(with: coordinate)
    }
    
}
