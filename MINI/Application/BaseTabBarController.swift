//
//  BaseTabBarController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
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
                barTitle: "Bank",
                image: "house.fill"),
            createVC(
                AviaBuilder.build(),
                barTitle: "Tickets",
                image: "airplane"),
            createVC(
                GroceryBuilder.build(),
                barTitle: "Grocery",
                image: "basket.fill"),
            createVC(
                ProfileBuilder.build(),
                barTitle: "Profile",
                image: "person.fill")
        ]
    }
    
    func createVC(_ vc: UIViewController, barTitle: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = barTitle
        navController.tabBarItem.image = UIImage(systemName: image)
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
