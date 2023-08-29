//
//  ProfileInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func logout() throws
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    weak var presenter: ProfilePresenterProtocol?
    private var fbAuthManager: FBAuthProtocol?
    
    var profileData: [ProfileSection] = []
    
    init() {
        self.profileData = ProfileSection.data
        self.fbAuthManager = FBAuthManager()
    }
    
    func viewDidLoaded() {
        //
    }
    
    func logout() {
        fbAuthManager?.signOut()
    }
    
}

private extension ProfileInteractor {
    
}
