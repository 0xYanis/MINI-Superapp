//
//  GroceryViewSet.swift
//  MINI
//
//  Created by Yan Rybkin on 18.05.2023.
//

import UIKit

final class GroceryViewSet: UITableViewCell {
    
    let data: [[Int]] = [[1,2,3],[1,2,3,4,5,6],[1],[1,2],[1,2,3,4],[1,2,3,4,5]]
    
    //MARK: Public properties
    static let cellId = "GroceryViewSet"
    
    //MARK: Private properties
    private lazy var customView = UIView()
    private lazy var categoryLabel = UILabel()
    private var collectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Private methods
private extension GroceryViewSet {
    func initialize() {
        backgroundColor = .clear
        createCustomView()
        createLabelView()
        createCollectionView()
        collectionViewRegistrate()
    }
    
    func createCustomView() {
        customView.backgroundColor = .clear
        addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createLabelView() {
        categoryLabel.text = "Category"
        categoryLabel.textColor = .white
        categoryLabel.font = .boldSystemFont(ofSize: 20)
        customView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview()
        }
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        customView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 15, left: 16, bottom: 30, right: 16)
        return layout
    }
    
    func collectionViewRegistrate() {
        collectionView.register(
            GroceryViewCell.self,
            forCellWithReuseIdentifier: GroceryViewCell.cellId
        )
    }
}


//MARK: - UICollectionViewDataSource
extension GroceryViewSet: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GroceryViewCell.cellId,
            for: indexPath) as? GroceryViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? GroceryViewCell {
            cell.configure()
            cell.roundCorners(radius: 10)
        }
        
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GroceryViewSet: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                        indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 16
        let width = (collectionView.bounds.width - itemSpacing * 3) / 3
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
    }
}
