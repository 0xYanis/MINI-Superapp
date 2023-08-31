//
//  ProfileInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func userSetAvatar(_ imageData: Data)
    func logout()
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    weak var presenter: ProfilePresenterProtocol?
    private var fbAuthManager: FBAuthProtocol?
    private var fbStorageManager: FBStorageProtocol?
    
    var profileData: [ProfileSection] = []
    
    init() {
        self.profileData = ProfileSection.data
        self.fbAuthManager = FBAuthManager()
        self.fbStorageManager = FBStorageManager()
    }
    
    func viewDidLoaded() {
        //
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
