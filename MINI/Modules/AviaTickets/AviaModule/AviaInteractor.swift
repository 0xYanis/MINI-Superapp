//
//  AviaInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import Foundation

protocol AviaInteractorProtocol: AnyObject {
    var dataSource: [AviaSection] { get }
}

final class AviaInteractor: AviaInteractorProtocol {
    
    weak var presenter: AviaPresenterProtocol?
    
    var dataSource: [AviaSection] = AviaMockData.shared.sections
    
}

private extension AviaInteractor {
    
}
