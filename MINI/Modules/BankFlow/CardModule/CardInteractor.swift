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
    func deleteCard()
}

final class CardInteractor: CardInteractorProtocol {
    weak var presenter: CardPresenterProtocol?
    
    var cardData: Card?
    
    private var repository: CardRepositoryProtocol
    
    init(cardData: Card) {
        self.cardData = cardData
        self.repository = CardRepository()
    }
    
    func viewDidLoaded() {
        guard let cardData = cardData else { return }
        presenter?.udpateView(with: cardData)
    }
    
    func deleteCard() {
        guard let cardData else { return }
        try? repository.deleteCard(cardData)
    }
    
}
