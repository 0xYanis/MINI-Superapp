//
//  SupportPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 23.08.2023.
//

import Foundation

protocol SupportPresenterProtocol: AnyObject {
    func getMessages() -> [Message]
    func createMessage(text: String)
    func removeMessage(with index: Int)
}

final class SupportPresenter: SupportPresenterProtocol {
    
    weak var view: SupportViewProtocol?
    
    private var messages: [Message] = []
    
    init(view: SupportViewProtocol) {
        self.view = view
        firstMessage()
    }
    
    func getMessages() -> [Message] {
        return messages
    }
    
    func createMessage(text: String) {
        let message = Message(
            message: text,
            time: .now,
            isMine: true)
        messages.append(message)
    }
    
    func removeMessage(with index: Int) {
        messages.remove(at: index)
    }
    
    private func firstMessage() {
        let text = "Добрый день! Вам чем-то помочь?"
        let message = Message(message: text, time: .now, isMine: false)
        messages.append(message)
    }
    
}
