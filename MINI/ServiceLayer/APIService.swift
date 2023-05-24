//
//  APIService.swift
//  MINI
//
//  Created by Yan Rybkin on 24.05.2023.
//

import Foundation
import Alamofire

protocol APIServiceProtocol: AnyObject {
    
    associatedtype DataType
    
    func getRequest(url: String, completion: @escaping (Result<DataType, Error>) -> Void)
    func postRequest(url: String, parameters: [String : Any]?, completion: @escaping (Result<DataType, Error>) -> Void)
    func putRequest(url: String, parameters: [String : Any]?, completion: @escaping (Result<DataType, Error>) -> Void)
    func patchRequest(url: String, parameters: [String : Any]?, completion: @escaping (Result<DataType, Error>) -> Void)
    func deleteRequest(url: String, completion: @escaping (Result<DataType, Error>) -> Void)
}

final class APIService< T : Codable >: APIServiceProtocol {
    
    typealias DataType = T
    typealias handler<T> = (Result<T, Error>) -> Void
    
    func getRequest(
        url: String,
        completion: @escaping handler<T>
    ) {
        performRequest(
            url: url,
            method: .get,
            completion: completion
        )
    }
    
    func postRequest(
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
    
    func putRequest(
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
    
    func patchRequest(
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
    
    func deleteRequest(
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
    private func performRequest(
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
