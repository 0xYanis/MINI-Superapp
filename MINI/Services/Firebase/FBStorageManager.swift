//
//  FBStorageManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseStorage
import Foundation

public protocol FBStorageProtocol: AnyObject {
    typealias uploadClosure = (Result<URL, StorageError>) -> Void
    func removeAvatar(_ uid: String)
    func uploadAvatar(_ data: Data, userID: String, completion: @escaping uploadClosure)
}

public enum StorageError: Error {
    case someError
    case invalidUpload
    case invalidURL
}

final public class FBStorageManager: FBStorageProtocol {
    typealias uploadClosure = (Result<URL, StorageError>) -> Void
    
    private let storage = Storage.storage()
    
    public func removeAvatar(_ uid: String) {
        let path = storage.reference().child("\(Consts.avatars.rawValue)/\(uid)")
        path.delete { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func uploadAvatar(_ data: Data, userID: String, completion: @escaping uploadClosure) {
        // - storage/avatars/<userID>.jpeg
        let path = avatars.child(userID)
        let metadata = StorageMetadata()
        metadata.contentType = Consts.contentType.rawValue
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

// MARK: - Constants

private extension FBStorageManager {
    var avatars: StorageReference {
        storage.reference().child(Consts.avatars.rawValue)
    }
    
    enum Consts: String {
        case avatars
        case contentType = "image.jpeg"
    }
}
