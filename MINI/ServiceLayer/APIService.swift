//
//  APIService.swift
//  MINI
//
//  Created by Yan Rybkin on 24.05.2023.
//

import Foundation
import Alamofire

protocol APIServiceProtocol: AnyObject {
    func getRequest<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
    func postRequest<T: Codable>(url: String, parameters: [String : Any]?, completion: @escaping (Result<T, Error>) -> Void)
    func putRequest<T: Codable>(url: String, parameters: [String : Any]?, completion: @escaping (Result<T, Error>) -> Void)
    func patchRequest<T: Codable>(url: String, parameters: [String : Any]?, completion: @escaping (Result<T, Error>) -> Void)
    func deleteRequest<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
}


final class APIService: APIServiceProtocol {
    
    typealias handler<T> = (Result<T, Error>) -> Void
    
    func getRequest<T: Codable>(
        url: String,
        completion: @escaping handler<T>
    ) {
        performRequest(
            url: url,
            method: .get,
            completion: completion
        )
    }
    
    func postRequest<T: Codable>(
        url: String,
        parameters: [String : Any]?,
        completion: @escaping handler<T>
    ) {
        performRequest(
            url: url,
            method: .post,
            parameters: parameters,
            completion: completion
        )
    }
    
    func putRequest<T: Codable>(
        url: String,
        parameters: [String : Any]?,
        completion: @escaping handler<T>
    ) {
        performRequest(
            url: url,
            method: .put,
            parameters: parameters,
            completion: completion
        )
    }
    
    func patchRequest<T: Codable>(
        url: String,
        parameters: [String : Any]?,
        completion: @escaping handler<T>
    ) {
        performRequest(
            url: url,
            method: .patch,
            parameters: parameters,
            completion: completion
        )
    }
    
    func deleteRequest<T: Codable>(
        url: String,
        completion: @escaping handler<T>
    ) {
        performRequest(
            url: url,
            method: .delete,
            completion: completion
        )
    }
    
}

private extension APIService {
    private func performRequest<T: Codable>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
