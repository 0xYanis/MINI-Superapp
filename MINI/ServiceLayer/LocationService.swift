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
}

struct Location {
    var title: String
    var coordinate: CLLocationCoordinate2D?
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    typealias closure = ([Location]) -> Void
    
    private let manager  = CLLocationManager()
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
    
}
