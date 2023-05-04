//
//  AllTemplatesRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation
import UIKit

protocol AllTemplatesRouterProtocol: AnyObject {
    func goToTemplate()
}

final class AllTemplatesRouter: AllTemplatesRouterProtocol {
    weak var view: AllTemplatesViewController?
    
    func goToTemplate() {
        let templateView = TemplateBuilder.build()
        view?.navigationController?.pushViewController(templateView, animated: false)
    }
}
