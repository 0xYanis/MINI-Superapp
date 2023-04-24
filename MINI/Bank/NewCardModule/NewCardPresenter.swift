//
//  NewCardPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardPresenterProtocol: AnyObject {
    func viewDidLoaded()
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
    
}
