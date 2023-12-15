//
//  BaseTabBarController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

enum TabItem: Int {
    case bank
    case tickets
    case cart
    case grocery
    case profile
}

final class BaseTabBarController: UITabBarController {
    
    weak public var coordinator: TabBarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    public func updateBadge(item: TabItem, value: Int) {
        tabBar.updateBadge(item: item, value: value)
    }
    
    public func removeBadge(item: TabItem) {
        tabBar.removeBadge(item: item)
    }
    
}

private extension BaseTabBarController {
    
    func initialize() {
        addViewControllers()
        createBorder()
        addBlurEffect()
    }
    
    func addViewControllers() {
        viewControllers = [
            createVC(
                BankBuilder.build(),
                barTitle: "bank_tabbar".localized,
                image: UIImage.SystemSymbol.houseFill.rawValue),
            createVC(
                AviaBuilder.build(),
                barTitle: "tickets_tabbar".localized,
                image: UIImage.SystemSymbol.airplane.rawValue),
            createVC(
                CartBuilder.build(),
                barTitle: "Корзина",
                image: UIImage.SystemSymbol.cartFill.rawValue),
            createVC(
                GroceryBuilder.build(),
                barTitle: "grocery_tabbar".localized,
                image: UIImage.SystemSymbol.basketFill.rawValue),
            createVC(
                ProfileBuilder.build(),
                barTitle: "profile_tabbar".localized,
                image: UIImage.SystemSymbol.personFill.rawValue)
        ]
    }
    
    func createVC(
        _ vc: UIViewController,
        barTitle: String,
        image: String
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = barTitle
        
        let symbolConf = UIImage.SymbolConfiguration(weight: .medium)
        navController.tabBarItem.image = UIImage(
            systemName: image,
            withConfiguration: symbolConf
        )
        return navController
    }
    
    func createBorder() {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.3)
        topBorder.backgroundColor = UIColor.gray.cgColor
        tabBar.layer.addSublayer(topBorder)
    }
    
    func addBlurEffect() {
        tabBar.tintColor = .systemOrange
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tabBar.insertSubview(blurView, at: 0)
    }
    
}
