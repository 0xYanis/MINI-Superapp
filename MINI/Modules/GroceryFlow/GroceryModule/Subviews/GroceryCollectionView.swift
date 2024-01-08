//
//  GroceryCollectionView.swift
//  MINI
//
//  Created by Yan Rybkin on 22.06.2023.
//

import UIKit
import SnapKit

final class GroceryCollectionView: UICollectionView {
    
    weak var presenter: GroceryPresenterProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension GroceryCollectionView {
    
    func initialize() {
        dataSource = self
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        collectionViewRegistrate()
    }
    
    func collectionViewRegistrate() {
        register(
            GroceryViewCell.self,
            forCellWithReuseIdentifier: String(describing: GroceryViewCell.self)
        )
        register(
            GroceryHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: GroceryHeaderCell.self)
        )
    }
    
}

//MARK: - UICollectionViewDataSource

extension GroceryCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView
    ) -> Int {
        presenter?.getGroceryData().count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter?.getGroceryData()[section].items.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let data = presenter?.getGroceryData()[indexPath.section].items[indexPath.row],
              let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: GroceryViewCell.self),
            for: indexPath) as? GroceryViewCell
        else { return UICollectionViewCell() }
        
        cell.configure(with: data)
        return cell
    }
    
}

//MARK: - Header titles for sections

extension GroceryCollectionView {
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let type = presenter?.getGroceryData()[indexPath.section].type,
              let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: GroceryHeaderCell.self),
            for: indexPath
        ) as? GroceryHeaderCell else {
            return UICollectionReusableView()
        }
        view.configure(with: type.rawValue)
        return view
    }
    
}
