//
//  UITagPickerView.swift
//  MINI
//
//  Created by Yan Rybkin on 12.09.2023.
//

import UIKit

protocol UITagPickerDataSource: AnyObject {
    var items: [String] { get }
    func didTap(on index: Int)
}

final class UITagPickerView: UICollectionView {
    
    weak var datasource: UITagPickerDataSource?
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .horizontal
        dataSource = self
        delegate = self
        register(
            UITagPickerCell.self,
            forCellWithReuseIdentifier: String(describing: UITagPickerCell.self)
        )
        
        selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
    
}

// MARK: - UICollectionViewDataSource

extension UITagPickerView: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        datasource?.items.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.addCell(UITagPickerCell.self, at: indexPath)
        let data = datasource?.items ?? []
        cell.configure(item: data[indexPath.item])
        return cell
    }
    
}

extension UITagPickerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        datasource?.didTap(on: indexPath.item)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = getWidth(at: indexPath.item)
        return .init(width: width, height: collectionView.frame.height)
    }
    
    private func getWidth(at index: Int) -> CGFloat {
        let nameFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let attributes = [NSAttributedString.Key.font : nameFont as Any]
        let width = datasource?.items[index].size(withAttributes: attributes).width ?? 0
        return width + 20
    }
    
}

final class UITagPickerCell: UICollectionViewCell {
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? .systemOrange : .tertiaryLabel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiaryLabel
        layer.cornerRadius = 10
        
        addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(item: String) {
        tagLabel.text = item
    }
    
}
