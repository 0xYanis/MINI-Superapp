//
//  CardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class CardInteractor: CardInteractorProtocol {
    weak var presenter: CardPresenterProtocol?
    
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func viewDidLoaded() {
        
    }
}
