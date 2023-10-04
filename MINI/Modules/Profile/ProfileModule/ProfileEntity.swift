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
}

struct ProfileOption {
    var title: String
    var icon: String?
    var iconBackground: String
    var enumeration: [String] = []
    var switcher: Bool = false
    var type: ProfileDetails
}

enum ProfileDetails {
    case favorites
    case tickets
    case orders
    case transactions
    case notifications
    case language
    case email
    case password
    case support
    case logout
    case deleteAccount
}

var profileTableData: [ProfileSection] = [
    ProfileSection(title: "", options: []), // User data section
    ProfileSection(title: "Общее", options: [
        ProfileOption(title: "Избранное", icon: "bookmark.fill", iconBackground: "#FFA500", type: .favorites),
        ProfileOption(title: "Мои билеты", icon: "airplane", iconBackground: "#0000FF", type: .tickets),
        ProfileOption(title: "Мои заказы", icon: "cart.fill", iconBackground: "#008000", type: .orders),
        ProfileOption(title: "Мои транзакции", icon: "creditcard.fill", iconBackground: "#FF49D2", type: .transactions),
    ]),
    ProfileSection(title: "", options: []),
    ProfileSection(title: "Настройки", options: [
        ProfileOption(title: "Уведомления", icon: "bell.badge.fill", iconBackground: "#800080", switcher: true, type: .notifications),
        ProfileOption(title: "Язык", icon: "globe", iconBackground: "#FF5070", enumeration: ["Русский","English"], type: .language),
        ProfileOption(title: "Почта", icon: "mail.fill", iconBackground: "#1E81B0", type: .email),
        ProfileOption(title: "Пароль", icon: "lock", iconBackground: "#FFBF49", type: .password),
    ]),
    ProfileSection(title: "", options: []),
    ProfileSection(title: "Дополнительно", options: [
        ProfileOption(title: "Поддержка", icon: "info.circle", iconBackground: "#A0A0A0", type: .support),
        ProfileOption(title: "Выйти", icon: "arrowshape.turn.up.backward.fill", iconBackground: "#A0A0A0", type: .logout),
        ProfileOption(title: "Удалить аккаунт", icon: "person.crop.circle.fill.badge.minus", iconBackground: "#FF0000", type: .deleteAccount)
    ]),
    ProfileSection(title: "", options: [])
]
