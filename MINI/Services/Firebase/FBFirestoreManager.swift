//
//  FBFirestoreManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseAuth
import FirebaseFirestore

public protocol FBFirestoreProtocol: AnyObject {
    func setUserData(user: User)
    func getUserData(uid: String?, completion: @escaping ([String:Any])->Void)
    func updateUserData(uid: String?, updatedData: [String: Any])
    func removeUserData(_ uid: String)
}

final public class FBFirestoreManager: FBFirestoreProtocol {
    typealias UserDict = [String:Any]
    
    private let db = Firestore.firestore()
    
    public func setUserData(user: User) {
        let path = users.document(user.uid)
        path.setData([
            Consts.users.rawValue   : user.email?.getEmailName() ?? "",
            Consts.email.rawValue   : user.email ?? "",
            Consts.address.rawValue : "None"
        ])
    }
    
    public func getUserData(uid: String?, completion: @escaping (UserDict) -> Void) {
        guard let uid = uid else { return }
        let path = users.document(uid)
        path.getDocument { snapshot, error in
            guard
                let data = snapshot?.data(),
                error == nil
            else { return }
            completion(data)
        }
    }
    
    public func updateUserData(uid: String?, updatedData: UserDict) {
        guard let uid = uid else { return }
        let path = users.document(uid)
        path.updateData(updatedData)
    }
    
    public func removeUserData(_ uid: String) {
        let path = users.document(uid)
        path.delete()
    }
}

// MARK: - Constants

private extension FBFirestoreManager {
    var users: CollectionReference {
        db.collection(Consts.users.rawValue)
    }
    
    enum Consts: String {
        case users
        case name
        case email
        case address
    }
}
