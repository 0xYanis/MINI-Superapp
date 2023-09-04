//
//  FBFirestoreManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseAuth
import FirebaseFirestore

protocol FBFirestoreProtocol: AnyObject {
    func setUserData(uid: String?, data: [String: Any])
    func updateUserData(uid: String?, updatedData: [String: Any])
}

final class FBFirestoreManager: FBFirestoreProtocol {
    
    private let db = Firestore.firestore()
    
    public func setUserData(uid: String?, data: [String: Any]) {
        guard let uid = uid else { return }
        let path = db.collection("users").document(uid)
        path.setData(data)
        
    }
    
    public func updateUserData(uid: String?, updatedData: [String: Any]) {
        guard let uid = uid else { return }
        let path = db.collection("users").document(uid)
        path.updateData(updatedData)
    }
    
}

