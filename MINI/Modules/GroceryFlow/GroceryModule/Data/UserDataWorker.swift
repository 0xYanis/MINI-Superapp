//
//  UserDataWorker.swift
//  MINI
//
//  Created by Yanis on 06.12.2023.
//

import Foundation

protocol UserDataWorker: AnyObject {
    func getUserAddres(completion: @escaping (String) -> Void)
    func saveUserAddress(_ address: String)
    
    func getUserName(completion: @escaping (String) -> Void)
    func getUserData(completion: @escaping (_ name: String,_ address: String) -> Void)
    func saveAvatar(_ image: Data, completion: @escaping (URL) -> ()?)
}

final class UserDataWorkerImpl: UserDataWorker {
    
    private var fbStorageManager: FBStorageProtocol
    private var fbFirestoreManager: FBFirestoreProtocol
    private var userId: String?
    
    init() {
        self.fbStorageManager = FBStorageManager()
        self.fbFirestoreManager = FBFirestoreManager()
        self.userId = UserDefaults.standard.string(forKey: "uid")
    }
    
    func getUserAddres(completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            self.fbFirestoreManager.getUserData(uid: self.userId) { result in
                guard let address = result["address"] as? String
                else { return }
                completion(address)
            }
        }
    }
    
    func saveUserAddress(_ address: String) {
        DispatchQueue.global().async {
            self.fbFirestoreManager.updateUserData(
                uid: self.userId,
                updatedData: ["address": address])
        }
    }
    
    func getUserName(completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            self.fbFirestoreManager.getUserData(uid: self.userId) { result in
                guard let name = result["name"] as? String
                else { return }
                completion(name.capitalized)
            }
        }
    }
    
    func getUserData(completion: @escaping (_ name: String,_ address: String) -> Void) {
        DispatchQueue.global().async {
            self.fbFirestoreManager.getUserData(uid: self.userId) { result in
                guard let name = result["name"] as? String,
                      let address = result["address"] as? String
                else { return }
                completion(name, address)
            }
        }
    }
    
    func saveAvatar(_ image: Data, completion: @escaping (URL) -> ()?) {
        guard let userId else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            self.fbStorageManager.uploadAvatar(image,userID: userId) { result in
                switch result {
                case .success(let url):
                    completion(url)
                case .failure(_): break
                }
            }
        }
    }
    
}
