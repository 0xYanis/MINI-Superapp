//
//  FBUserRemover.swift
//  MINI
//
//  Created by Yan Rybkin on 04.09.2023.
//

import Foundation

final public class FBUserRemover {
    static public let shared = FBUserRemover()
    
    private let auth: FBAuthProtocol           = FBAuthManager()
    private let storage: FBStorageProtocol     = FBStorageManager()
    private let firestore: FBFirestoreProtocol = FBFirestoreManager()
    
    private init() {}
    
    public func deleteUser() {
        guard let user = auth.currentUser else { return }
        let uid = user.uid
        firestore.removeUserData(uid)
        storage.removeAvatar(uid)
        user.delete()
    }
}
