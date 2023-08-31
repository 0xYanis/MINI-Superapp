//
//  FBFirestoreManager.swift
//  MINI
//
//  Created by Yan Rybkin on 31.08.2023.
//

import FirebaseFirestore

protocol FBFirestoreProtocol: AnyObject {
    
}

final class FBFirestoreManager: FBFirestoreProtocol {
    
    private let db = Firestore.firestore()
    
}
