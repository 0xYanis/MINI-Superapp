//
//  OnboardingEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import Foundation

struct OnboardingEntity {
    
    var title: String
    var message: String
    var animation: String
    
    static var first: OnboardingEntity = .init(
        title: "Совершайте заказы",
        message: Message.first.rawValue,
        animation: "ordersAnimation")
    static var second: OnboardingEntity = .init(
        title: "Планируйте авиаперелеты",
        message: Message.second.rawValue,
        animation: "travelAnimation")
    static var third: OnboardingEntity = .init(
        title: "Следите за тратами",
        message: Message.third.rawValue,
        animation: "spendingAnimation")
    
    private enum Message: String {
        case first =
        """
        Удобно и быстро делайте покупки, добавляйте товары в корзину и выбирайте удобный способ оплаты.
        """
        case second = """
        Планируйте свои авиаперелеты, выбирайте маршруты, даты и время вылета, сравнивайте цены от различных авиакомпаний.
        """
        case third = """
        Отслеживайте свои финансовые расходы, вносите информацию о трате и доходе, анализируйте свои финансовые привычки.
        """
    }
    
}
