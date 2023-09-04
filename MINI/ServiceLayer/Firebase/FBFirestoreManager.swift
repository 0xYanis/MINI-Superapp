//
//  FBFirestoreManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseAuth
import FirebaseFirestore

protocol FBFirestoreProtocol: AnyObject {
    func setUserData(user: User)
    func updateUserData(uid: String?, updatedData: [String: Any])
}

final class FBFirestoreManager: FBFirestoreProtocol {
    
    private let db = Firestore.firestore()
    
    public func setUserData(user: User) {
        let path = db.collection("users").document(user.uid)
        path.setData([
            "name" : user.email?.getEmailName() ?? "User",
            "email" : user.email ?? "",
            "address" : "None"
        ])
    }
    
    public func updateUserData(uid: String?, updatedData: [String: Any]) {
        guard let uid = uid else { return }
        let path = db.collection("users").document(uid)
        path.updateData(updatedData)
    }
    
    
}

extension String {
    func getEmailName() -> String? {
        let components = self.components(separatedBy: "@")
        return components.first
    }
}

