//
//  MapViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import UIKit
import SnapKit
import MapKit
import FloatingPanel

protocol MapViewProtocol: AnyObject {
    
}

final class MapViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var mapView = MKMapView()
    private lazy var panel = FloatingPanelController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showFloatingPanel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideFloatingPanel()
    }
    
}

// MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    
}

// MARK: - Private methods

private extension MapViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.title = "Адрес"
        navigationItem.largeTitleDisplayMode = .never
        createMapView()
    }
    
    func createMapView() {
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func showFloatingPanel() {
        let address = AdressViewController()
        address.delegate = self
        panel.set(contentViewController: address)
        panel.surfaceView.appearance.cornerRadius = 12
        panel.addPanel(toParent: self)
    }
    
    func hideFloatingPanel() {
        panel.hide(animated: true) {
            self.panel.view.removeFromSuperview()
            self.panel.removeFromParent()
        }
    }
    
}

extension MapViewController: AdressViewDelegate {
    
    func searchResults() -> [Location] {
        return []
    }
    
    func searchAdress(with text: String) {
        
    }
    
    func didTapResult(with index: Int) {
        
    }
    
    
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
}
