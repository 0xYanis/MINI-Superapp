//
//  UICollectionView+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 28.08.2023.
//

import UIKit

extension UICollectionView {
    
    func addCell<C: UICollectionViewCell>(
        _ cell: C.Type,
        at indexPath: IndexPath
    ) -> C {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: String(describing: cell),
            for: indexPath
        ) as? C else { fatalError("Error \(cell)") }
        return cell
    }
    
}
