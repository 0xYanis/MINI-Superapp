//
//  DeepLinkManager.swift
//  MINI
//
//  Created by Yan Rybkin on 26.05.2023.
//

import Foundation
import UIKit

final class DeepLinkManager {
    
    private var shortcuts: [UIApplicationShortcutItem] = []
    
    private lazy var searchTransactions = UIMutableApplicationShortcutItem(
        type: Consts.searchTransactions.rawValue,
        localizedTitle: "shortcut_transactions".localized,
        localizedSubtitle: "",
        icon: UIApplicationShortcutIcon(type: .search)
    )
    
    private enum Consts: String {
        case searchTransactions
    }
    
    init() {
        self.shortcuts.append(searchTransactions)
    }
    
    func buildShortCuts() -> [UIApplicationShortcutItem] {
        return shortcuts
    }
    
}
