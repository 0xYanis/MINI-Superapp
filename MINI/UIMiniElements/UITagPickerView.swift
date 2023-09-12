//
//  UITagPickerView.swift
//  MINI
//
//  Created by Yan Rybkin on 12.09.2023.
//

import UIKit

protocol UITagPickerDelegate: AnyObject {
    func didTap(on index: Int)
}

final class UITagPickerView: UICollectionView {
    
    weak var pickerDelegate: UITagPickerDelegate?
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    private var tags: [String]
    
    init(_ tags: [String]) {
        self.tags = tags
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        showsHorizontalScrollIndicator = false
        backgroundColor = .none
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
        tags.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.addCell(UITagPickerCell.self, at: indexPath)
        cell.configure(item: tags[indexPath.item])
        return cell
    }
    
}

extension UITagPickerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        pickerDelegate?.didTap(on: indexPath.item)
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
        let nameFont = UIFont.boldSystemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font : nameFont as Any]
        let width = tags[index].size(withAttributes: attributes).width
        return width + 20
    }
    
}

final class UITagPickerCell: UICollectionViewCell {
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        roundCorners(radius: 12)
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
