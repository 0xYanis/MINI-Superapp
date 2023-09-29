//
//  FBNotificationManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseMessaging

protocol FBNotificationProtocol: AnyObject {
    func subscribe(to topic: String)
    func unsubscribe(from topic: String)
}

final class FBNotificationManager: FBNotificationProtocol {
    
    private let messaging = Messaging.messaging()
    
    public func subscribe(to topic: String) {
        messaging.subscribe(toTopic: topic)
    }
    
    public func unsubscribe(from topic: String) {
        messaging.unsubscribe(fromTopic: topic)
    }
    
}

