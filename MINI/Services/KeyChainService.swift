//
//  KeyChainService.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import Foundation

public protocol KeyChainServiceProtocol {
    func getValue(forKey key: String) -> String?
    func setValue(_ value: String, forKey key: String)
    func removeValue(forKey key: String)
}

public final class KeyChainService: KeyChainServiceProtocol {
    private let keyChain: KeyChainProtocol
    
    public init(keyChain: KeyChainProtocol = KeyChain()) {
        self.keyChain = keyChain
    }
    
    public func getValue(forKey key: String) -> String? {
        return keyChain.getValue(forKey: key)
    }
    
    public func setValue(_ value: String, forKey key: String) {
        keyChain.setValue(value, forKey: key)
    }
    
    public func removeValue(forKey key: String) {
        keyChain.removeValue(forKey: key)
    }
    
}
