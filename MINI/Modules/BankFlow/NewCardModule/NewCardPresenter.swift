//
//  NewCardPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol NewCardPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func setFormTextFields(_ textFields: [FormTableView.FormField])
    
    func didTapAddButton()
    func popToRoot()
}

final class NewCardPresenter {
    
    weak var view: NewCardViewProtocol?
    
    private var router: NewCardRouterProtocol
    private var interactor: NewCardInteractorProtocol
    
    init(router: NewCardRouterProtocol, interactor: NewCardInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension NewCardPresenter: NewCardPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func setFormTextFields(_ textFields: [FormTableView.FormField]) {
        view?.setFormTextFields(textFields)
    }
    
    func didTapAddButton() {
        interactor.addCard()
    }
    
    func popToRoot() {
        router.popToRoot()
    }
    
}
