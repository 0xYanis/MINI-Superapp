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
    func getUserData(uid: String?, completion: @escaping ([String:Any])->Void)
    func updateUserData(uid: String?, updatedData: [String: Any])
}

final class FBFirestoreManager: FBFirestoreProtocol {
    
    private let db = Firestore.firestore()
    
    public func setUserData(user: User) {
        let path = db.collection("users").document(user.uid)
        path.setData([
            "name" : user.email?.getEmailName() ?? "",
            "email" : user.email ?? "",
            "address" : "None"
        ])
    }
    
    public func getUserData(uid: String?, completion: @escaping ([String:Any])->Void) {
        guard let uid = uid else { return }
        let path = db.collection("users").document(uid)
        path.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  error == nil
            else { return }
            completion(data)
        }
    }
    
    public func updateUserData(uid: String?, updatedData: [String: Any]) {
        guard let uid = uid else { return }
        let path = db.collection("users").document(uid)
        path.updateData(updatedData)
    }
    
}

