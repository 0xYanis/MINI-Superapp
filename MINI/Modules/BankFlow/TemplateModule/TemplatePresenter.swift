//
//  TemplatePresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 28.04.2023.
//

import Foundation

protocol TemplatePresenterProtocol: AnyObject {
    
}

final class TemplatePresenter {
    
    weak var view: TemplateViewProtocol?
    
    private var interactor: TemplateInteractorProtocol
    private var router: TemplateRouterProtocol
    
    init(interactor: TemplateInteractorProtocol, router: TemplateRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension TemplatePresenter: TemplatePresenterProtocol {
    
}
