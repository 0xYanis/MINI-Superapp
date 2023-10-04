//
//  KeyChainService.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

protocol KeyChainServiceProtocol {
    func getValue(forKey key: String) -> String?
    func setValue(_ value: String, forKey key: String)
    func removeValue(forKey key: String)
}

final class KeyChainService: KeyChainServiceProtocol {
    
    private let keyChain: KeyChainProtocol
    
    init(keyChain: KeyChainProtocol = KeyChain()) {
        self.keyChain = keyChain
    }
    
    func getValue(forKey key: String) -> String? {
        return keyChain.getValue(forKey: key)
    }
    
    func setValue(_ value: String, forKey key: String) {
        keyChain.setValue(value, forKey: key)
    }
    
    func removeValue(forKey key: String) {
        keyChain.removeValue(forKey: key)
    }
    
}
