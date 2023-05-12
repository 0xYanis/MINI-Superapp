//
//  CardPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardPresenterProtocol: AnyObject {
    func viewDidLoaded()
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
    
    func userWantToEditCard() {
        
    }
    
    func userWantToDeleteCard() {
        
    }
}
