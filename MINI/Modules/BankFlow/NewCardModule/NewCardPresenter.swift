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
    func updateFieldMark(of field: Int, with state: Bool)
    
    func updateView(dataIsCorrect: Bool)
    func enterText(_ text: String, fieldId: Int)
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
    
    func updateView(dataIsCorrect: Bool) {
        view?.updateView(dataIsCorrect: dataIsCorrect)
    }
    
    func enterText(_ text: String, fieldId: Int) {
        interactor.enterText(text, fieldId: fieldId)
    }
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func setFormTextFields(_ textFields: [FormTableView.FormField]) {
        view?.configureTextFields(textFields)
    }
    
    func updateFieldMark(of field: Int, with state: Bool) {
        view?.updateFieldMark(of: field, with: state)
    }
    
    func didTapAddButton() {
        interactor.addCard()
        popToRoot()
    }
    
    func popToRoot() {
        router.popToRoot()
    }
    
}
