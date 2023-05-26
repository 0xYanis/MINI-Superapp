//
//  LoginLottieService.swift
//  MINI
//
//  Created by Yan Rybkin on 26.05.2023.
//

import Foundation
import Lottie

protocol LoginLottieServiceProtocol: AnyObject {
    typealias handler = (_ animation: Result<LottieAnimation, Error>?) -> Void
    
    func loadAnimation(completion: @escaping handler)
}

final class LoginLottieService: LoginLottieServiceProtocol {
    
    var apiService: APIServiceProtocol
    private let url = "https://assets8.lottiefiles.com/packages/lf20_rbtawnwz.json"
    
    init(
        apiService: APIServiceProtocol
    ) {
        self.apiService = apiService
    }
    
    func loadAnimation(completion: @escaping handler) {
        apiService.getRequest(url: url) { (result: Result<LottieAnimation, Error>) in
            switch result {
            case .success(let lottie):
                completion(.success(lottie))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
