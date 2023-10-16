//
//  PaymentInteractor.swift
//  MINI
//
//  Created by Yanis on 16.10.2023.
//

import Foundation

protocol PaymentInteractorProtocol: AnyObject {
    
}

final class PaymentInteractor: PaymentInteractorProtocol {
    
    weak var presenter: PaymentPresenterProtocol?
    
}
