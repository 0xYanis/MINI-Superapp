//
//  MapBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import UIKit

final class MapBuilder {
    
    static func build() -> UIViewController {
        let view = MapViewController()
        let presenter = MapPresenter(view: view)
        
        let location = LocationService()
        let fbFirestoreManager = FBFirestoreManager()
        
        view.presenter = presenter
        presenter.locationService = location
        presenter.fbFirestoreManager = fbFirestoreManager
        
        return view
    }
    
}
