//
//  AviaRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import Foundation
import UIKit

protocol AviaRouterProtocol: AnyObject {
    func goDetailResult(id: Int)
}

final class AviaRouter: AviaRouterProtocol {
    
    weak var view: UIViewController?
    
    func goDetailResult(id: Int) {
        let resultView = UIViewController()
        resultView.view.backgroundColor = .white
        view?.navigationController?.push(resultView)
    }
    
}
