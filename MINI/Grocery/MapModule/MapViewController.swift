//
//  MapViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import UIKit
import SnapKit
import MapKit

protocol MapViewProtocol: AnyObject {
    
}

final class MapViewController: UIViewController {
    
    private lazy var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        view.backgroundColor = .back2MINI
        
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
}
