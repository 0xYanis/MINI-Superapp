//
//  GroceryPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import Foundation

protocol GroceryPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func updateView()
    
    func userWantSetNewAdress()
    func userDidTapDetailCategory(id: Int)
    
    func searchBarTextDidChange(with searchText: String)
    
    func getGroceryData() -> [[GroceryEntity]]
    func loadingDataGetFailed(with message: String)
}

final class GroceryPresenter {
    weak var view: GroceryViewProtocol?
    var router: GroceryRouterProtocol
    var interactor: GroceryInteractorProtocol
    
    init(
        router: GroceryRouterProtocol,
        interactor: GroceryInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
    
    
}

extension GroceryPresenter: GroceryPresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func updateView() {
        view?.updateView()
    }
    
    func userWantSetNewAdress() {
        
    }
    
    func userDidTapDetailCategory(id: Int) {
        router.goToDetailCategory(with: id)
    }
    
    func searchBarTextDidChange(with searchText: String) {
        interactor.searchBarTextDidChange(with: searchText)
    }
    
    func getGroceryData() -> [[GroceryEntity]] {
        interactor.getGroceryData()
    }
    
    func loadingDataGetFailed(with message: String) {
        view?.showLoadingDataGetFailed(with: message)
    }
}
