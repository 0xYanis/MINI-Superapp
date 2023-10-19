//
//  UITabBar+Extension.swift
//  MINI
//
//  Created by Yanis on 18.10.2023.
//

import UIKit

extension UITabBar {
    
    func updateBadge(item: TabItem, value: Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[item.rawValue]
            tabItem.badgeValue = "\(value)"
            tabItem.badgeColor = .systemRed
        }
    }
    
    func removeBadge(item: TabItem) {
        if let tabItems = self.items {
            let tabItem = tabItems[item.rawValue]
            tabItem.badgeValue = nil
        }
    }
    
 }
