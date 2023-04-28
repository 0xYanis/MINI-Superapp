//
//  AllTemplatesPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol AllTemplatesPresenterProtocol: AnyObject {
    func userDidTapTemplate(id: Int)
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
    func userDidTapTemplate(id: Int) {
        router.goToTemplate()
    }
    
    func userWillDeleteTemplate(id: Int) {
        interactor.userWillDeleteTemplate(id: id)
    }
}