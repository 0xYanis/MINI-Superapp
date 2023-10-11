//
//  CardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardInteractorProtocol: AnyObject {
    var cardData: Card? { get }
    func viewDidLoaded()
}

final class CardInteractor: CardInteractorProtocol {
    weak var presenter: CardPresenterProtocol?
    
    var cardData: Card?
    
    init(cardData: Card) {
        self.cardData = cardData
    }
    
    func viewDidLoaded() {
        guard let cardData = cardData else { return }
        presenter?.udpateView(with: cardData)
    }
    
}
