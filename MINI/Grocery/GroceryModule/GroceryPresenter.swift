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
    func userStartSearchAdress(with searchText: String)
    func getSearchAdressesResults() -> [String]
    func userDidTapDetailCategory(id: Int)
    
    func userDidTapCart()
    func userDidTapSearchProduct()
    
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
    
    func userStartSearchAdress(with searchText: String) {
        interactor.userStartSearchAdress(with: searchText)
    }
    
    func getSearchAdressesResults() -> [String] {
        interactor.adressesData
    }
    
    func userDidTapDetailCategory(id: Int) {
        router.goToDetailCategory(with: id)
    }
    
    func userDidTapCart() {
        router.goToCartView()
    }
    
    func userDidTapSearchProduct() {
        router.goToSearchView()
    }
    
    func getGroceryData() -> [[GroceryEntity]] {
        interactor.groceryData
    }
    
    func loadingDataGetFailed(with message: String) {
        view?.showLoadingDataGetFailed(with: message)
    }
    
}
