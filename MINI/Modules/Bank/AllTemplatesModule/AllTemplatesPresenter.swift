//
//  AllTemplatesPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol AllTemplatesPresenterProtocol: AnyObject {
    
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
    
    func getTemplatesData() -> [Template] {
        interactor.tempaltesData
    }
    
    func userDidTapTemplate(id: Int) {
        router.goToTemplate(id: id)
    }
    
    func userDidTapAddNew() {
        router.goToAddNewTemplate()
    }
    
    func userWillDeleteTemplate(id: Int) {
        interactor.userWillDeleteTemplate(id: id)
    }
    
    func userWillMoveTemplate(from: Int, to: Int) {
        interactor.userWillMoveTemplate(from: from, to: to)
    }
    
}
