//
//  LocationService.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    func getCurrentCity(completion: @escaping (String?) -> Void)
    func getPlacemarksByAddress(_ address: String, city: String, completion: @escaping ([String]?) -> Void)
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    private let geocoder = CLGeocoder()
    private var locationManager: CLLocationManager?
    
    func getCurrentCity(completion: @escaping (String?) -> Void) {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        locationManager?.startUpdatingLocation()
        
        guard let location = locationManager?.location else {
            completion(nil)
            return
        }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("Reverse geocoding failed: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            
            completion(placemark.locality)
        }
    }
    
    func getPlacemarksByAddress(_ address: String, city: String, completion: @escaping ([String]?) -> Void) {
        geocoder.geocodeAddressString("\(address), \(city)") { placemarks, error in
            guard error == nil else {
                print("Geocoding failed: \(error!.localizedDescription)")
                completion([])
                return
            }
            
            guard let placemarks = placemarks else {
                completion([])
                return
            }
            
            var addresses: [String] = []
            for placemark in placemarks {
                if let address = placemark.name {
                    addresses.append(address)
                }
            }
            completion(addresses)
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
}

