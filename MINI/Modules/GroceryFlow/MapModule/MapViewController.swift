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
    func setResults(_ results: [LocalSearchResult])
    func showError(message: String)
    func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D)
    func removeAnnotation()
}

final class MapViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: MapPresenterProtocol?
    
    // MARK: - Private properties
    
    private var mapView = MapView()
    
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
    
    func setResults(_ results: [LocalSearchResult]) {
        addressView.addressList = results
    }
    
    func showError(message: String) {
        
    }
    
    func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
        mapView.addAnnotation(withCoordinate: coordinate)
        panelView.move(to: .tip, animated: true)
    }
    
    func removeAnnotation() {
        mapView.removeAnnotation()
    }
    
}

// MARK: - Private methods

private extension MapViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.title = "Адрес"
        navigationItem.largeTitleDisplayMode = .never
        view.insertSubview(mapView, at: 0)
        mapView.frame = view.bounds
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
    
    func searchAdress(with text: String) {
        if let region = mapView.currentRegion {
            presenter?.searchAdress(with: text, region: region)
        }
    }
    
    func didTapResult(with index: Int) {
        presenter?.didTapResult(with: index)
    }
    
}
