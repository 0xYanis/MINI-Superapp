//
//  ProfileRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func userWantToLogout()
    func userWantToDetailView(of type: ProfileDetails)
}

final class ProfileRouter: ProfileRouterProtocol {
    
    weak var view: UIViewController?
    
    func userWantToLogout() {
        if let tabBarController = view?.tabBarController as? BaseTabBarController {
            tabBarController.coordinator?.finish()
        }
    }
    
    func userWantToDetailView(of type: ProfileDetails) {
        let defView = UIViewController()
        defView.view.backgroundColor = .back2MINI
        
        switch type {
        case .favorites:
            goToDetailView(to: PayoutsBuilder.build(.favorites))
        case .tickets:
            goToDetailView(to: PayoutsBuilder.build(.tickets))
        case .orders:
            goToDetailView(to: PayoutsBuilder.build(.orders))
        case .transactions:
            goToDetailView(to: PayoutsBuilder.build(.transactions))
            
        case .language:
            languageSheet()
        case .email:
            goToDetailView(to: defView)
        case .password:
            goToDetailView(to: PasswordBuilder.build())
        case .support:
            goToDetailView(to: defView)
        default: return
        }
    }
    
    private func goToDetailView(to module: UIViewController) {
        view?.navigationController?.pushViewController(
            module,
            animated: true
        )
    }
    
    private func languageSheet() {
        let controller = UIAlertController(
            title: "Сменить язык",
            message: "Выберите предпочитаемый язык",
            preferredStyle: .actionSheet
        )
        
        controller.addAction(UIAlertAction(title: "Русский", style: .default))
        controller.addAction(UIAlertAction(title: "English", style: .default))
        controller.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        view?.present(controller, animated: true)
    }
    
}
