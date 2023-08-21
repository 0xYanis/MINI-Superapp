//
//  PayoutsInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import Foundation

protocol PayoutsInteractorProtocol: AnyObject {
    func getData() -> [PayoutsModel]
}

final class PayoutsInteractor: PayoutsInteractorProtocol {
    
    weak var presenter: PayoutsPresenterProtocol?
    
    private var payoutsData: [PayoutsModel] = [
        .init(image: "AppIcon", title: "Чизбургер с беконом", description: "Сочный чизбургер с беконом для компании или одиноких посиделок перед грустным фильмом"),
        .init(image: "AppIcon", title: "Чизбургер с беконом", description: "посиделок перед грустным фильмом"),
        .init(image: "AppIcon", title: "Чизбургер с беконом", description: "Сочный чизбургер с беконом для компании или одиноких"),
        .init(image: "AppIcon", title: "Чизбургер с беконом", description: "Сочный чизбургер "),
        .init(image: "AppIcon", title: "Чизбургер с беконом", description: "Сочный чизбургер с беконом для компании или одиноких посиделок перед грустным фильмом Сочный чизбургер с беконом для компании или одиноких посиделок перед грустным фильмом")
    ]
    
    func getData() -> [PayoutsModel] {
        return payoutsData
    }
    
}
