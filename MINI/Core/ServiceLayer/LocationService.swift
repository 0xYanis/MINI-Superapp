//
//  LocationService.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    typealias closure = ([Location]) -> Void
    func findLocations(with query: String, completion: @escaping closure)
    func getCurrentLocation(completion: @escaping (CLLocation) -> Void)
}

struct Location {
    var title: String
    var coordinate: CLLocationCoordinate2D?
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    typealias closure = ([Location]) -> Void
    typealias current = (CLLocation) -> Void
    
    private var manager: CLLocationManager {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }
    
    private let geocoder = CLGeocoder()
    
    public func findLocations(with query: String, completion: @escaping closure) {
        geocoder.geocodeAddressString(query) { placemarks, error in
            guard let placemarks = placemarks,
                  error == nil
            else { return completion([]) }
            
            let models: [Location] = placemarks
                .compactMap { place in
                    var name = ""
                    if let locationName = place.name {
                        name += locationName
                    }
                    if let adminRegion = place.administrativeArea {
                        name += ", \(adminRegion)"
                    }
                    if let locality = place.locality {
                        name += ", \(locality)"
                    }
                    if let country = place.country {
                        name += ", \(country)"
                    }
                    let result = Location(
                        title: name,
                        coordinate: place.location?.coordinate)
                    return result
                }
            
            completion(models)
        }
    }
    
    public func getCurrentLocation(completion: @escaping current) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location services are disabled")
            return
        }
        
        manager.requestLocation()
        
        if let location = manager.location {
            completion(location)
        }
        
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        
    }
    
}
