//
//  ProfileInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    var profileData: [ProfileSection] { get }
    var userName: String { get }
    var userAddress: String { get }
    
    func viewDidLoaded()
    func userSetAvatar(_ imageData: Data)
    func logout()
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    weak var presenter: ProfilePresenterProtocol?
    
    public var userName: String = ""
    public var userAddress: String = ""
    public var profileData: [ProfileSection] = profileTableData
    
    private var fbAuthManager: FBAuthProtocol
    private var fbStorageManager: FBStorageProtocol
    private var fbFirestoreManager: FBFirestoreProtocol
    
    init(
        fbAuthManager: FBAuthProtocol,
        fbStorageManager: FBStorageProtocol,
        fbFirestoreManager: FBFirestoreProtocol
    ) {
        self.fbAuthManager = fbAuthManager
        self.fbStorageManager = fbStorageManager
        self.fbFirestoreManager = fbFirestoreManager
    }
    
    // MARK: - Public methods
    
    public func viewDidLoaded() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.getUserData()
        }
    }
    
    public func userSetAvatar(_ imageData: Data) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let uid = self.fbAuthManager.currentUser?.uid
            else { return }
            self.fbStorageManager.uploadAvatar(
                imageData,
                userID: uid
            ) { [weak self] result in
                switch result {
                case .success(let url):
                    self?.updateURLAvatar(url)
                    DispatchQueue.main.async {
                        self?.presenter?.updateView()
                    }
                case .failure(_): break
                }
            }
        }
    }
    
    public func logout() {
        fbAuthManager.signOut()
    }
    
    // MARK: - Private methods
    
    private func updateURLAvatar(_ url: URL) {
        UserDefaults.standard.set(url, forKey: "avatarUrl")
    }
    
    private func getUserData() {
        let uid = UserDefaults.standard.string(forKey: "uid")
        self.fbFirestoreManager.getUserData(uid: uid) { [weak self] result in
            guard
                let self = self,
                let name = result["name"] as? String,
                let address = result["address"] as? String
            else { return }
            self.userName = name.capitalized
            self.userAddress = address
            DispatchQueue.main.async {
                self.presenter?.updateView()
            }
        }
    }
    
}
