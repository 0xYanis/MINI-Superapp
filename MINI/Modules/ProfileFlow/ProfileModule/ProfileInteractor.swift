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
    private var userDataWorker: UserDataWorker
    
    init(
        fbAuthManager: FBAuthProtocol,
        fbStorageManager: FBStorageProtocol,
        fbFirestoreManager: FBFirestoreProtocol
    ) {
        self.fbAuthManager = fbAuthManager
        self.fbStorageManager = fbStorageManager
        self.fbFirestoreManager = fbFirestoreManager
        self.userDataWorker = UserDataWorkerImpl()
    }
    
    // MARK: - Public methods
    
    public func viewDidLoaded() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.getUserData()
        }
    }
    
    public func userSetAvatar(_ imageData: Data) {
        userDataWorker.saveAvatar(imageData) { [weak self] url in
            self?.updateURLAvatar(url)
            DispatchQueue.main.async {
                self?.presenter?.updateView()
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
        userDataWorker.getUserData { [weak self] name, address in
            self?.userName = name
            self?.userAddress = address
            DispatchQueue.main.async {
                self?.presenter?.updateView()
            }
        }
    }
    
}
