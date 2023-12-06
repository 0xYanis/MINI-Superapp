//
//  MapView.swift
//  MINI
//
//  Created by Yanis on 06.12.2023.
//

import UIKit
import MapKit

final class MapView: UIView {
    
    // MARK: - Public properties
    
    var userLocation: CLLocationCoordinate2D?
    var currentRegion: MKCoordinateRegion?
    
    // MARK: - Private properties
    
    private let mkMapView = MKMapView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mkMapView.frame = bounds
    }
    
    public func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
        mkMapView.removeAnnotations(mkMapView.annotations)
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = coordinate
        mkMapView.addAnnotation(annotaion)
        mkMapView.selectAnnotation(annotaion, animated: true)
    }
    
    public func removeAnnotation() {
        mkMapView.removeAnnotations(mkMapView.annotations)
        if let currentRegion {
            mkMapView.setRegion(currentRegion, animated: true)
        }
    }
    
    private func configure() {
        mkMapView.userTrackingMode = .follow
        mkMapView.showsUserLocation = true
        mkMapView.isRotateEnabled = false
        mkMapView.delegate = self
        
        insertSubview(mkMapView, at: 0)
    }
    
}

extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.userLocation = userLocation.coordinate
        let region = MKCoordinateRegion(
            center: .init(
                latitude: userLocation.coordinate.latitude,
                longitude: userLocation.coordinate.longitude),
            span: .init(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05)
        )
        self.currentRegion = region
        mkMapView.setRegion(region, animated: true)
    }
    
}
