//
//  GrocerySearchController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit

final class GrocerySearchController: UISearchController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension GrocerySearchController {
    func initialize() {
        searchBar.delegate = self
        
    }
}

extension GrocerySearchController: UISearchBarDelegate {
    
}
