//
//  NewCardRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation
import UIKit

protocol NewCardRouterProtocol: AnyObject {
    func popToRoot()
}

final class NewCardRouter: NewCardRouterProtocol {
    
    weak var view: UIViewController?
    
    func popToRoot() {
        view?.navigationController?.popViewController(animated: true)
    }
}
