//
//  NewCardPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func userSetBank(_ text: String?)
    func userSetNumber(_ text: String?)
    func userSetCVV(_ text: String?)
    
    func userSetInvalidCard(with message: String)
    func userSetValidCard()
}

final class NewCardPresenter {
    weak var view: NewCardViewProtocol?
    var router: NewCardRouterProtocol
    var interactor: NewCardInteractorProtocol
    
    init(router: NewCardRouterProtocol, interactor: NewCardInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension NewCardPresenter: NewCardPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func userSetBank(_ text: String?) {
        guard let text = text else { return }
        interactor.userSetBank(text)
    }
    
    func userSetNumber(_ text: String?) {
        guard let text = text else { return }
        interactor.userSetNumber(text)
    }
    
    func userSetCVV(_ text: String?) {
        guard let text = text else { return }
        interactor.userSetCVV(text)
    }
    
    func userSetInvalidCard(with message: String) {
        view?.cardIsInvalid(message)
    }
    
    func userSetValidCard() {
        router.popToRoot()
    }
    
}
