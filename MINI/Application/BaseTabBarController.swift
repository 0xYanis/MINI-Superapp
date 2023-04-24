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
        viewControllers = [
            createVC(BankBuilder.build(), barTitle: "Bank", image: "house.fill"),
            createVC(UIViewController(), barTitle: "Tickets", image: "airplane"),
            createVC(UIViewController(), barTitle: "Grocery", image: "basket.fill"),
            createVC(UIViewController(), barTitle: "Profile", image: "person.fill")
        ]
        createBorder()
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
        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.gray.cgColor
        tabBar.layer.addSublayer(topBorder)
    }
}
