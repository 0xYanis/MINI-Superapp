//
//  ProfileEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 16.06.2023.
//

import Foundation

struct ProfileSection {
    let title: String
    let options: [ProfileOption]
    
    static let data: [ProfileSection] = [
        ProfileSection(title: "", options: []), // Empty section for user data
        ProfileSection(title: "Общее", options: [
            ProfileOption(title: "Избранное", icon: "bookmark.fill", iconBackground: "#FFA500", type: .favorites),
            ProfileOption(title: "Мои билеты", icon: "airplane", iconBackground: "#0000FF", type: .tickets),
            ProfileOption(title: "Мои заказы", icon: "cart.fill", iconBackground: "#008000", type: .orders),
            ProfileOption(title: "Мои транзакции", icon: "creditcard.fill", iconBackground: "#FFFF00", type: .transactions),
        ]),
        ProfileSection(title: "Настройки", options: [
            ProfileOption(title: "Уведомления", icon: "bell.badge.fill", iconBackground: "#800080", isToggling: true, type: .notifications),
            ProfileOption(title: "Язык", icon: "globe", iconBackground: "#FF5070", enumeration: ["Русский","English"], type: .language),
            ProfileOption(title: "Пароль", icon: "lock", iconBackground: "#808080", type: .password),
            ProfileOption(title: "Поддержка", icon: "info.circle", iconBackground: "#A0A0A0", type: .support),
        ])
    ]
    
}

struct ProfileOption {
    var title: String
    var icon: String?
    var iconBackground: String
    var isToggling: Bool = false
    var enumeration: [String] = []
    var type: ProfileDetails
}

enum ProfileDetails {
    case favorites
    case tickets
    case orders
    case transactions
    case notifications
    case language
    case password
    case support
}
