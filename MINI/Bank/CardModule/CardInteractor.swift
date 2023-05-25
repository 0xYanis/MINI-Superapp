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
    
    var data: CardDetailEntity?
    
    init(data: Any) {
        self.data = data as? CardDetailEntity
    }
    
    func viewDidLoaded() {
        
    }
}
