//
//  AllTemplatesPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol AllTemplatesPresenterProtocol: AnyObject {
    
    func viewDidLoaded()
    func updateView()
    
    func getTemplatesData() -> [Template]
    
    func userDidTapTemplate(id: Int)
    func userDidTapAddNew()
    
    func userWillMoveTemplate(from: Int, to: Int)
    func userWillDeleteTemplate(id: Int)
}

final class AllTemplatesPresenter {
    
    weak var view: AllTemplatesViewProtocol?
    var router: AllTemplatesRouterProtocol
    var interactor: AllTemplatesInteractorProtocol
    
    init(router: AllTemplatesRouterProtocol, interactor: AllTemplatesInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension AllTemplatesPresenter: AllTemplatesPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.fetchTemplates()
    }
    
    func updateView() {
        view?.updateView()
    }
    
    func getTemplatesData() -> [Template] {
        interactor.tempaltes
    }
    
    func userDidTapTemplate(id: Int) {
        router.goToTemplate(id: id)
    }
    
    func userDidTapAddNew() {
        router.goToAddNewTemplate()
    }
    
    func userWillDeleteTemplate(id: Int) {
        interactor.deleteTemplate(id: id)
    }
    
    func userWillMoveTemplate(from: Int, to: Int) {
        interactor.moveTemplate(from: from, to: to)
    }
    
}
