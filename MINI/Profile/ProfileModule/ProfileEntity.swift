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
        ProfileSection(title: "Общее", options: [
            ProfileOption(title: "Мой профиль", icon: "house", iconBackground: "#FFA500"),
            ProfileOption(title: "Мои билеты", icon: "airplane", iconBackground: "#0000FF"),
            ProfileOption(title: "FaceID", icon: "faceid", iconBackground: "#008000"),
            ProfileOption(title: "Настройки", icon: "gear", iconBackground: "#FFFF00"),
        ]),
        ProfileSection(title: "Настройки", options: [
            ProfileOption(title: "Уведомления", icon: "bell", iconBackground: "#800080"),
            ProfileOption(title: "Язык", icon: "globe", iconBackground: "#FF0000"),
            ProfileOption(title: "Пароль", icon: "lock", iconBackground: "#808080"),
            ProfileOption(title: "Поддержка", icon: "info.circle", iconBackground: "#A0A0A0"),
        ])
    ]
    
}

struct ProfileOption {
    let title: String
    let icon: String?
    let iconBackground: String
}
