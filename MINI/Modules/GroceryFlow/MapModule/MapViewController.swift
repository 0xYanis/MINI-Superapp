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
    func updateView()
    func setPin(with coordinate: CLLocationCoordinate2D?)
    func setCurrentLocation(location: CLLocation)
}

final class MapViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: MapPresenterProtocol?
    
    // MARK: - Private properties
    
    private var mapView: MKMapView!
    private var trackerButton: MKUserTrackingBarButtonItem!
    
    private lazy var panelView   = FloatingPanelController()
    private lazy var addressView = AdressViewController()
    
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
        presenter?.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideFloatingPanel()
    }
    
}

// MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    
    func updateView() {
        addressView.updateView()
    }
    
    func setPin(with coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        
        panelView.move(to: .tip, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.7,
                longitudeDelta: 0.7)
        )
        
        mapView.setRegion(region, animated: true)
    }
    
    func setCurrentLocation(location: CLLocation) {
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
}

// MARK: - Private methods

private extension MapViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.title = "Адрес"
        navigationItem.largeTitleDisplayMode = .never
        createMapView()
        createMKButtons()
    }
    
    func createMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }
    
    func createMKButtons() {
        trackerButton = MKUserTrackingBarButtonItem(mapView: mapView)
        navigationItem.rightBarButtonItem = trackerButton
    }
    
    func showFloatingPanel() {
        addressView.delegate = self
        panelView.set(contentViewController: addressView)
        panelView.surfaceView.appearance.cornerRadius = 12
        panelView.addPanel(toParent: self, animated: true)
    }
    
    func hideFloatingPanel() {
        panelView.hide(animated: true) {
            self.panelView.view.removeFromSuperview()
            self.panelView.removeFromParent()
        }
    }
    
}

extension MapViewController: AdressViewDelegate {
    
    func searchResults() -> [Placemark] {
        presenter?.searchResults ?? []
    }
    
    func searchAdress(with text: String) {
        presenter?.searchAdress(with: text)
    }
    
    func didTapResult(with index: Int) {
        presenter?.didTapResult(with: index)
    }
    
}