//
//  SupportBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 23.08.2023.
//

import UIKit

final class SupportBuilder {
    
    static func build() -> UIViewController {
        let view = SupportViewContoller()
        let presenter = SupportPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
    
}
