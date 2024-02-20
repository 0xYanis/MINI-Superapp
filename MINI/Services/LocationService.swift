//
//  LocationService.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import Foundation
import CoreLocation

final public class LocationService: NSObject {
    static public let shared = LocationService()
    
    public var userLocation: CLLocationCoordinate2D?
    public var userRegion: CLCircularRegion?
    
    private let manager = CLLocationManager()
    
    override private init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    public func request() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
}

// MARK: - CLLocationManagerDelegate

public extension LocationService: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        manager.stopUpdatingLocation()
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didEnterRegion region: CLRegion
    ) {
        guard let region = region as? CLCircularRegion
        else {  return }
        userRegion = region
    }
    
}
