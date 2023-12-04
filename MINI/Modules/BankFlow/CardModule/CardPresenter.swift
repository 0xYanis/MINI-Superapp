//
//  CardPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func udpateView(with data: Card)
    
    func getCardData() -> Card?
    
    func userWantToEditCard()
    func userWantToDeleteCard()
}

final class CardPresenter {
    weak var view: CardViewProtocol?
    private var router: CardRouterProtocol
    private var interactor: CardInteractorProtocol
    
    init(router: CardRouterProtocol, interactor: CardInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension CardPresenter: CardPresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func udpateView(with data: Card) {
        view?.updateView(with: data)
    }
    
    func getCardData() -> Card? {
        interactor.cardData
    }
    
    func userWantToEditCard() {
        router.userWantToEditCard()
    }
    
    func userWantToDeleteCard() {
        interactor.deleteCard()
        router.goBackToBankView()
    }
    
}
