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
    private let hapticEngine = UINotificationFeedbackGenerator()
    
    private var tags: [String] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with tags: [String]) {
        self.tags = tags
        initialize()
    }
    
    private func initialize() {
        hapticEngine.prepare()
        
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
        hapticEngine.notificationOccurred(.success)
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
            backgroundColor = isSelected ? .systemOrange : .tertiaryLabel
            if isSelected { pulseAnimation() }
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
    
    private func pulseAnimation() {
        UIView.animate(withDuration: 0.04) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.06) {
                self?.transform = CGAffineTransform.identity
            }
        }
    }
    
}
