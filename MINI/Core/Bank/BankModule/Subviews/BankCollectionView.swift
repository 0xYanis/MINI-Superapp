//
//  BankCollectionView.swift
//  MINI
//
//  Created by Yanis on 02.10.2023.
//

import UIKit

final class BankCollectionView: UICollectionView {
    
    public var presenter: BankPresenterProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        backgroundColor = .none
        dataSource = self
        delegate = self
        
//        register(C.self)
//        register(C.self)
//        register(C.self)
//        register(C.self)
        
//        collectionViewLayout = makeLayout()
    }
    
    private func register<C: UICollectionViewCell>(_ cell: C.Type) {
        register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    
}

private extension BankCollectionView {
    
//    func makeLayout() -> UICollectionViewLayout {
//        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, env in
//            guard let self = self else { return nil }
//            let section = self.presenter.getDataSource()[sectionIndex]
//            switch section { }
//        }
//    }
    
}

//MARK: - UICollectionViewDataSource

extension BankCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        15
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return dequeue(UICollectionViewCell.self, collectionView, indexPath)
    }
    
    private func dequeue<C: UICollectionViewCell>(
        _ cell: C.Type,
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath
    ) -> C {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: cell),
            for: indexPath) as? C
        else { fatalError("Error from cell: \(cell)") }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension BankCollectionView: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        //presenter?.userWantToDetails(of: ., with: indexPath.item)
    }
    
}
