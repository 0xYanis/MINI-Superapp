//
//  UserDataWorker.swift
//  MINI
//
//  Created by Yanis on 06.12.2023.
//

import Foundation

protocol UserDataWorker: AnyObject {
    func saveUserAddress(_ address: String)
    func getUserAddres(completion: @escaping (String) -> Void)
}

final class UserDataWorkerImpl: UserDataWorker {
    
    private var fbFirestoreManager: FBFirestoreProtocol
    
    init() {
        self.fbFirestoreManager = FBFirestoreManager()
    }
    
    func saveUserAddress(_ address: String) {
        let uid = UserDefaults.standard.string(forKey: "uid")
        DispatchQueue.global().async {
            self.fbFirestoreManager.updateUserData(
                uid: uid,
                updatedData: ["address": address])
        }
    }
    
    func getUserAddres(completion: @escaping (String) -> Void) {
        let uid = UserDefaults.standard.string(forKey: "uid")
        self.fbFirestoreManager.getUserData(uid: uid) { result in
            guard let address = result["address"] as? String
            else { return }
            completion(address)
        }
    }
    
}
