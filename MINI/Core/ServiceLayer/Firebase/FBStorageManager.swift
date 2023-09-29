//
//  FBStorageManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseStorage
import Foundation

protocol FBStorageProtocol: AnyObject {
    typealias uploadClosure = (Result<URL, StorageError>) -> Void
    func removeAvatar(_ uid: String)
    func uploadAvatar(_ data: Data, userID: String, completion: @escaping uploadClosure)
}

enum StorageError: Error {
    case someError
    case invalidUpload
    case invalidURL
}

final class FBStorageManager: FBStorageProtocol {
    
    typealias uploadClosure = (Result<URL, StorageError>) -> Void
    
    private let storage = Storage.storage()
    
    public func removeAvatar(_ uid: String) {
        let path = storage.reference().child("avatars/\(uid)")
        path.delete { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func uploadAvatar(_ data: Data, userID: String, completion: @escaping uploadClosure) {
        // - storage/avatars/<userID>.jpeg
        let referance = storage.reference()
        let path = referance.child("avatars").child(userID)
        let metadata = StorageMetadata()
        metadata.contentType = "image.jpeg"
        path.putData(data, metadata: metadata) { metadata, error in
            if error != nil {
                completion(.failure(.someError))
                return
            }
            
            guard let _ = metadata else {
                completion(.failure(.invalidUpload))
                return
            }
            
            path.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(.invalidURL))
                    return
                }
                completion(.success(url))
            }
        }
    }
    
}
