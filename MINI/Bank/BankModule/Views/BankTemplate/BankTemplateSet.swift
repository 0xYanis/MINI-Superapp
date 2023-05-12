//
//  BankTemplateSet.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit

final class BankTemplateSet: UITableViewCell {
    
    weak var delegate: BankViewCellDelegate?
    static let cellId = "BankTemplateSet"
    
    private var collectionView: UICollectionView!
    private let snapLayout = StackFlowLayout()
    
    private var image: String = "gear"
    private var templateName: String = "Template"
    
    func configure(_ image: String,_ template: String) {
        self.image = image
        templateName = template
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension BankTemplateSet {
    func initialize() {
        createCollectionView()
        addConstraintsOfView()
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: snapLayout
        )
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            BankTemplateCell.self, forCellWithReuseIdentifier: BankTemplateCell.cellId
        )
        collectionView.backgroundColor = UIColor(named: "backColor")
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func addConstraintsOfView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension BankTemplateSet: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BankTemplateCell.cellId,
            for: indexPath) as? BankTemplateCell else { return UICollectionViewCell() }
        cell.configure(image, templateName)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BankTemplateSet: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 3
        return .init(width: width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.handleTapOnTemplateCell(id: indexPath.item)
    }
}
