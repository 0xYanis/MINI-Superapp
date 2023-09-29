//
//  ProfilePresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 22.05.2023.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func updateView()
    func viewDidLoaded()
    func getProfileData() -> [ProfileSection]
    
    func getUserData() -> (name: String, address: String)
    func userSetAvatar(_ imageData: Data)
    func userWantToDetailView(of type: ProfileDetails)
    
    func userWantToLogout()
}

final class ProfilePresenter {
    
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol
    var interactor: ProfileInteractorProtocol
    
    init(
        router: ProfileRouterProtocol,
        interactor: ProfileInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func updateView() {
        view?.updateView()
    }
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func getUserData() -> (name: String, address: String) {
        return (interactor.userName, interactor.userAddress)
    }
    
    func getProfileData() -> [ProfileSection] {
        interactor.profileData
    }
    
    func userSetAvatar(_ imageData: Data) {
        interactor.userSetAvatar(imageData)
    }
    
    func userWantToDetailView(of type: ProfileDetails) {
        if type == .logout {
            view?.showAlert()
        } else {
            router.userWantToDetailView(of: type)
        }
    }
    
    func userWantToLogout() {
        interactor.logout()
        router.userWantToLogout()
    }
    
}
