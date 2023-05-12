//
//  AllTemplatesRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation
import UIKit

protocol AllTemplatesRouterProtocol: AnyObject {
    func goToTemplate(id: Int)
}

final class AllTemplatesRouter: AllTemplatesRouterProtocol {
    weak var view: UIViewController?
    
    func goToTemplate(id: Int) {
        let templateView = TemplateBuilder.build()
        view?.navigationController?.pushViewController(templateView, animated: true)
    }
}
