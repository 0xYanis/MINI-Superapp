//
//  PlacemarkService.swift
//  MINI
//
//  Created by Yan Rybkin on 04.09.2023.
//

import MapKit
import UIKit

protocol PlacemarkServiceProtocol: AnyObject {
    typealias closure = (Result<[Placemark], Error>) -> Void
    func searchPlace(_ place: String, completion: @escaping closure)
}

final class PlacemarkService: NSObject, PlacemarkServiceProtocol {
    
    typealias closure = (Result<[Placemark], Error>) -> Void
    
    private let locationManager = CLLocationManager()
    private let request = MKLocalSearch.Request()
    private var localSearch: MKLocalSearch?
    private var region = MKCoordinateRegion()
    
    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    public func searchPlace(_ place: String, completion: @escaping closure) {
        localSearch?.cancel()
        
        request.naturalLanguageQuery = place
        request.region = region
        localSearch = MKLocalSearch(request: request)
        localSearch?.start { response, error in
            guard let items = response?.mapItems else {
                completion(.failure(NSError(domain: "", code: 333)))
                return
            }
            
            let placemarks = items.map { Placemark(item: $0) }
            completion(.success(placemarks))
        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension PlacemarkService: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        
        guard let lastLocation = locations.last else {
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        region = MKCoordinateRegion(center: lastLocation.coordinate, span: span)
    }
    
}

struct Placemark {
    
    let location: String
    
    init(item: MKMapItem) {
        
        var locationString: String = ""
        
        if let name = item.name {
            locationString += "\(name)"
        }
        
        if let locality = item.placemark.locality, locality != item.name {
            locationString += ", \(locality)"
        }
        
        if let administrativeArea = item.placemark.administrativeArea,
           administrativeArea != item.placemark.locality {
            locationString += ", \(administrativeArea)"
        }
        
        if let country = item.placemark.country, country != item.name {
            locationString += ", \(country)"
        }
        
        location = locationString
    }
}
