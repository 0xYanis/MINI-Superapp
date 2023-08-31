//
//  FBStorageManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseStorage

protocol FBStorageProtocol: AnyObject {
    
}

final class FBStorageManager: FBStorageProtocol {
    
    private let storage = Storage.storage()
    
}
