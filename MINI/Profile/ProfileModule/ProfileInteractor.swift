//
//  ProfileInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    var userName: String { get }
    var userAddress: String { get }
    
    func viewDidLoaded()
    func userSetAvatar(_ imageData: Data)
    func logout()
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    weak var presenter: ProfilePresenterProtocol?
    private var fbAuthManager: FBAuthProtocol?
    private var fbStorageManager: FBStorageProtocol?
    private var fbFirestoreManager: FBFirestoreProtocol?
    
    var userName: String = ""
    var userAddress: String = ""
    var profileData: [ProfileSection] = []
    
    init() {
        self.profileData = ProfileSection.data
        self.fbAuthManager = FBAuthManager()
        self.fbStorageManager = FBStorageManager()
        self.fbFirestoreManager = FBFirestoreManager()
    }
    
    func viewDidLoaded() {
        getUserData()
    }
    
    func getUserData() {
        let uid = UserDefaults.standard.string(forKey: "uid")
        print(uid)
        DispatchQueue.global().async {
            self.fbFirestoreManager?.getUserData(uid: uid) { result in
                guard
                    let name = result["name"] as? String,
                    let address = result["address"] as? String
                else { return }
                print(result)
                self.userName = name.capitalized
                self.userAddress = address
                DispatchQueue.main.async {
                    self.presenter?.updateView()
                }
            }
        }
    }
    
    func userSetAvatar(_ imageData: Data) {
        DispatchQueue.global().async {
            guard let uid = self.fbAuthManager?.currentUser?.uid
            else { return }
            self.fbStorageManager?.uploadAvatar(
                imageData,
                userID: uid
            ) { [weak self] result in
                switch result {
                case .success(let url): print("success")
                    self?.updateURLAvatar(url)
                    break
                case .failure(_): print("failure")
                    break
                }
            }
        }
    }
    
    func logout() {
        fbAuthManager?.signOut()
    }
    
}

private extension ProfileInteractor {
    
    func updateURLAvatar(_ url: URL) {
        UserDefaults.standard.set(url, forKey: "avatarUrl")
    }
    
}
