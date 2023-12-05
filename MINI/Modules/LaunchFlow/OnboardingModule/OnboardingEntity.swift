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
        animation: "order")
    static var second: OnboardingEntity = .init(
        title: "Планируйте авиаперелеты",
        message: Message.second.rawValue,
        animation: "travelAnimation")
    static var third: OnboardingEntity = .init(
        title: "Управляйте финансами",
        message: Message.third.rawValue,
        animation: "cardAnimation")
    
    private enum Message: String {
        case first =
        """
        Удобно и быстро делайте покупки,\nдобавляйте товары в корзину\nи выбирайте удобный способ оплаты.
        """
        case second = """
        Планируйте свои авиаперелеты,\nвыбирайте маршруты, даты и время вылета,\nсравнивайте цены от различных авиакомпаний.
        """
        case third = """
        Отслеживайте свои финансовые расходы,\nсоздавайте шаблоны для быстрой оплаты,\nанализируйте свои финансовые привычки.
        """
    }
    
}
