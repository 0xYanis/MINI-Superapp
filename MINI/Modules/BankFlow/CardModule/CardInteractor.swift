//
//  CardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardInteractorProtocol: AnyObject {
    var card: Card? { get }
    func viewDidLoaded()
    func deleteCard()
}

final class CardInteractor: CardInteractorProtocol {
    weak var presenter: CardPresenterProtocol?
    
    var card: Card?
    
    private var cardId: UUID
    private var repository: CardRepositoryProtocol
    
    init(_ cardId: UUID) {
        self.cardId = cardId
        self.repository = CardRepository()
    }
    
    func viewDidLoaded() {
        guard let card = repository.readCard(primaryKey: cardId)
        else { return }
        self.card = card
        presenter?.udpateView(with: card)
    }
    
    func deleteCard() {
        try? repository.deleteCard(key: cardId)
    }
    
}
