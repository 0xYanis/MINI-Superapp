//
//  GSearchPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 22.06.2023.
//

import Foundation

protocol GSearchPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func userDidTapProduct()
    func userStartSearch(with text: String)
    
    func updateViewWithData()
}

final class GSearchPresenter {
    
    weak var view: GSearchViewProtocol?
    
    private var router: GSearchRouterProtocol
    private var interactor: GSearchInteractorProtocol
    
    init(
        router: GSearchRouterProtocol,
        interactor: GSearchInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension GSearchPresenter: GSearchPresenterProtocol {
    func viewDidLoaded() {
        
    }
    
    func userDidTapProduct() {
        router.goToDetaiProduct()
    }
    
    func userStartSearch(with text: String) {
        
    }
    
    func updateViewWithData() {
        
    }
    
    
}
