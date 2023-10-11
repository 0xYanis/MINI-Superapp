//
//  CartBuilder.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import UIKit

final class CartBuilder {
	
	static func build() -> UIViewController {
		let view = CartViewController()
		let router = CartRouter()
		let interactor = CartInteractor()
		let presenter = CartPresenter(
			router: router, 
			interactor: interactor
		)
		
		view.presenter = presenter
		presenter.view = view
		router.view = view
		interactor.presenter = presenter
		
		return view
	}
	
}