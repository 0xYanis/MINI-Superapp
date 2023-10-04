//
//  NewTemplatePresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 25.04.2023.
//

import Foundation

protocol NewTemplatePresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class NewTemplatePresenter {
    weak var view: NewTemplateViewProtocol?
    
    private var router: NewTemplateRouterProtocol
    private var interactor: NewTemplateInteractorProtocol
    
    init(router: NewTemplateRouterProtocol, interactor: NewTemplateInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension NewTemplatePresenter: NewTemplatePresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
}
