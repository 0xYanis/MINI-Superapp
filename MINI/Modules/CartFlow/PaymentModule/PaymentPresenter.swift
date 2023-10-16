//
//  PaymentPresenter.swift
//  MINI
//
//  Created by Yanis on 16.10.2023.
//

import Foundation

protocol PaymentPresenterProtocol: AnyObject {
    
}

final class PaymentPresenter {
    
    // MARK: - Public properties
    
    weak var view: PaymentViewProtocol?
    
    // MARK: - Private properties
    
    private var router: PaymentRouterProtocol
    private var interactor: PaymentInteractorProtocol
    
    // MARK: - Init
    
    init(
        router: PaymentRouterProtocol,
        interactor: PaymentInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
    
}

// MARK: - PaymentPresenterProtocol

extension PaymentPresenter: PaymentPresenterProtocol {
    
}
