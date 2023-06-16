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
            ProfileOption(title: "Мой профиль", icon: "house", iconBackground: "systemOrange"),
            ProfileOption(title: "Мои билеты", icon: "airplane", iconBackground: "blue"),
            ProfileOption(title: "FaceID", icon: "faceid", iconBackground: "green"),
            ProfileOption(title: "Настройки", icon: "gear", iconBackground: "yellow"),
        ]),
        ProfileSection(title: "Настройки", options: [
            ProfileOption(title: "Уведомления", icon: "bell", iconBackground: "purple"),
            ProfileOption(title: "Язык", icon: "globe", iconBackground: "red"),
            ProfileOption(title: "Пароль", icon: "lock", iconBackground: "gray"),
            ProfileOption(title: "Поддержка", icon: "info.circle", iconBackground: "systemGray"),
        ])
    ]
    
}

struct ProfileOption {
    let title: String
    let icon: String?
    let iconBackground: String
}
