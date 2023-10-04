//
//  TemplateInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 28.04.2023.
//

import Foundation

protocol TemplateInteractorProtocol: AnyObject {
    
}

final class TemplateInteractor: TemplateInteractorProtocol {
    weak var presenter: TemplatePresenterProtocol?
    
}
