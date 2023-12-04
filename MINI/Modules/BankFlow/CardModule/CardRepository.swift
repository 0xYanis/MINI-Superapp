//
//  CardRepository.swift
//  MINI
//
//  Created by Yanis on 30.11.2023.
//

import Foundation

protocol CardRepositoryProtocol: AnyObject {
    func addCard(_ card: Card) throws
    func deleteCard(_ card: Card) throws
    func updateCard(_ card: Card) throws
    func fetchCards() throws -> [Card]
}

final class CardRepository: CardRepositoryProtocol {
    
    private let storage: RealmServiceProtocol
    
    init() {
        self.storage = RealmService()
    }
    
    func addCard(_ card: Card) throws {
        let object = CardObject(card)
        try storage.add(object)
    }
    
    func deleteCard(_ card: Card) throws {
        let object = CardObject(card)
        try storage.delete(object)
    }
    
    func updateCard(_ card: Card) throws {
        let object = CardObject(card)
        try storage.update(object)
    }
    
    func fetchCards() throws -> [Card] {
        let objects = try storage.fetch(CardObject.self)
        return objects.compactMap { Card($0) }
    }
    
}
