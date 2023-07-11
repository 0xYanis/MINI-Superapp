//
//  ProfileInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    weak var presenter: ProfilePresenterProtocol?
    
    var profileData: [ProfileSection] = []
    
    init() {
        self.profileData = ProfileSection.data
    }
    
    func viewDidLoaded() {
        // обновление состояния
        
        
    }
    
}

private extension ProfileInteractor {
    
}
