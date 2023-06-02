//
//  CardPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func udpateView(with data: BankCardModel)
    
    func getCardData() -> BankCardModel?
    
    func userWantToEditCard()
    func userWantToDeleteCard()
}

final class CardPresenter {
    weak var view: CardViewProtocol?
    var router: CardRouterProtocol
    var interactor: CardInteractorProtocol
    
    init(router: CardRouterProtocol, interactor: CardInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension CardPresenter: CardPresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func udpateView(with data: BankCardModel) {
        view?.updateView(with: data)
    }
    
    func getCardData() -> BankCardModel? {
        interactor.getCardData()
    }
    
    func userWantToEditCard() {
        
    }
    
    func userWantToDeleteCard() {
        router.goBackToBankView()
        // delete card
    }
}
