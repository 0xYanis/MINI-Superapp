//
//  LocationService.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    static let shared = LocationService()
    
    var userLocation: CLLocationCoordinate2D?
    
    private let manager = CLLocationManager()
    
    override private init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func request() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        manager.stopUpdatingLocation()
    }
    
}
