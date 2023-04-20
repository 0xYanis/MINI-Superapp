//
//  BankCardSet.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit

final class BankCardSet: UITableViewCell {
    
    static let cellId = "BankCardSet"
    
    // MARK: - Public method
    func configure() {
        
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var collectionView: UICollectionView!
}

//MARK: - Private methods
private extension BankCardSet {
    func initialize() {
        createCollectionView()
        addConstraintsOfView()
    }
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            BankCardCell.self, forCellWithReuseIdentifier: BankCardCell.cellId
        )
    }
    func addConstraintsOfView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.backgroundColor = UIColor(named: "backColor")
    }
}

// MARK: - UICollectionViewDataSource
extension BankCardSet: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BankCardCell.cellId,
            for: indexPath) as? BankCardCell else { return defaultCell }
        cell.configure()
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BankCardSet: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 2.5
        return .init(width: width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}
