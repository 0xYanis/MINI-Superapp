//
//  FBAuthManager.swift
//  MINI
//
//  Created by Yan Rybkin on 28.08.2023.
//

import FirebaseAuth

protocol FBAuthProtocol: AnyObject {
    typealias closure = (User?, Error?) -> Void
    
    func signIn(email: String, password: String, completion: @escaping closure)
    func signIn(token: String, completion: @escaping closure)
    func signUp(email: String, password: String, completion: @escaping closure)
    func signOut() throws
}

final class FBAuthManager: FBAuthProtocol {
    
    typealias closure  = (User?, Error?) -> Void
    private let firebase = Auth.auth()
    
    public func signIn(email: String, password: String, completion: @escaping closure) {
        firebase.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(nil, error)
            } else if let user = result?.user {
                completion(user, nil)
            }
        }
    }
    
    public func signIn(token: String, completion: @escaping closure) {
        firebase.signIn(withCustomToken: token) { result, error in
            if let error = error {
                completion(nil, error)
            } else if let user = result?.user {
                completion(user, nil)
            }
        }
    }
    
    public func signUp(email: String, password: String, completion: @escaping closure) {
        firebase.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(nil, error)
            } else if let user = result?.user {
                completion(user, nil)
            }
        }
    }
    
    public func signOut() throws {
        try firebase.signOut()
    }
}
