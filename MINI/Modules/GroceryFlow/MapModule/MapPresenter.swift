//
//  MapPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    var searchResults: [Placemark] { get }
    func viewDidAppear()
    func searchAdress(with text: String)
    func didTapResult(with index: Int)
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var locationService: LocationServiceProtocol?
    var placemarkService: PlacemarkServiceProtocol?
    var fbFirestoreManager: FBFirestoreProtocol?
    
    public var searchResults: [Placemark] = []
    
    init(view: MapViewProtocol) {
        self.view = view
    }
    
    func viewDidAppear() {
        DispatchQueue.global().async {
            self.locationService?.getCurrentLocation { [weak self] location in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.view?.setCurrentLocation(location: location)
                }
            }
        }
    }
    
    public func searchAdress(with text: String) {
        self.placemarkService = PlacemarkService()
        placemarkService?.configureService()
        DispatchQueue.global().async {
            self.placemarkService?.searchPlace(text) { [weak self] locations in
                guard let self = self else { return }
                self.searchResults = locations
                DispatchQueue.main.async {
                    self.view?.updateView()
                }
            }
        }
    }
    
    public func didTapResult(with index: Int) {
        if searchResults.isEmpty == false {
            let coordinate = searchResults[index].coordinate
            let location = searchResults[index].location
            setAddress(location)
            view?.setPin(with: coordinate)
        }
    }
    
    private func setAddress(_ address: String) {
        let uid = UserDefaults.standard.string(forKey: "uid")
        DispatchQueue.global().async {
            self.fbFirestoreManager?.updateUserData(
                uid: uid,
                updatedData: ["address": address])
        }
    }
    
}
