//
//  DeepLinkManager.swift
//  MINI
//
//  Created by Yan Rybkin on 26.05.2023.
//

import Foundation
import UIKit

final class DeepLinkManager: NSObject {
    static func buildShortCuts() -> [UIApplicationShortcutItem] {
        let searchTransactions = UIMutableApplicationShortcutItem(
            type: "searchTransactions",
            localizedTitle: "shortcut_transactions".localized,
            localizedSubtitle: "",
            icon: UIApplicationShortcutIcon(type: .search)
        )
        return [searchTransactions]
    }
    
}
