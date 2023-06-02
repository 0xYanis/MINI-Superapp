//
//  CardInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardInteractorProtocol: AnyObject {
    func viewDidLoaded()
    
    func getCardData() -> BankCardModel?
}

final class CardInteractor: CardInteractorProtocol {
    weak var presenter: CardPresenterProtocol?
    
    var cardData: BankCardModel?
    
    init(cardData: BankCardModel) {
        self.cardData = cardData
    }
    
    func viewDidLoaded() {
        guard let cardData = cardData else { return }
        presenter?.udpateView(with: cardData)
    }
    
    func getCardData() -> BankCardModel? {
        return cardData
    }
}
