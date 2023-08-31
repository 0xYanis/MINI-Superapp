//
//  ProfilePresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoaded()
    func getProfileData() -> [ProfileSection]
    
    func userSetAvatar(_ imageData: Data)
    func userWantToDetailView(of type: ProfileDetails)
    
    func userWantToLogout()
}

final class ProfilePresenter {
    
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol
    var interactor: ProfileInteractor
    
    init(
        router: ProfileRouterProtocol,
        interactor: ProfileInteractor
    ) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func getProfileData() -> [ProfileSection] {
        interactor.profileData
    }
    
    func userSetAvatar(_ imageData: Data) {
        interactor.userSetAvatar(imageData)
    }
    
    func userWantToDetailView(of type: ProfileDetails) {
        router.userWantToDetailView(of: type)
    }
    
    func userWantToLogout() {
        //interactor.сохрани состояние
        interactor.logout()
        router.userWantToLogout()
    }
    
}
