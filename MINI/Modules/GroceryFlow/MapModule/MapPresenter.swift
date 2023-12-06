//
//  MapPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 29.08.2023.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    func viewDidAppear()
    func searchAdress(with text: String)
    func didTapResult(with index: Int)
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var fbFirestoreManager: FBFirestoreProtocol?
    
    init(view: MapViewProtocol) {
        self.view = view
    }
    
    func viewDidAppear() {
        
    }
    
    public func searchAdress(with text: String) {
        
    }
    
    public func didTapResult(with index: Int) {
        
    }
    
    private func setAddress(_ address: String) {
        
    }
    
}
