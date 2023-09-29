//
//  PasswordPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 08.08.2023.
//

import Foundation

protocol PasswordPresenterProtocol: AnyObject {
    
}

final class PasswordPresenter: PasswordPresenterProtocol {
    
    weak var view: PasswordViewProtocol?
    
}
