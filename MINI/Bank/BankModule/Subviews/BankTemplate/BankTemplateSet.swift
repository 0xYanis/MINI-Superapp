//
//  BankTemplateSet.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit
import SkeletonView

final class BankTemplateSet: UITableViewCell, BankTableCellConf {
    
    //MARK: Public properties
    weak var presenter: BankPresenterProtocol?
    
    //MARK: Private properties
    private let snapLayout = StackFlowLayout()
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.decelerationRate = .fast
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(
                BankTemplateCell.self,
                forCellWithReuseIdentifier: String(describing: BankTemplateCell.self)
            )
            collectionView.backgroundColor = .clear
            collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public methods
    func reloadData() {
        collectionView.reloadData()
    }
    
}

//MARK: - Private methods
private extension BankTemplateSet {
    
    func initialize() {
        backgroundColor = .clear
        createCollectionView()
        addConstraintsOfView()
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: snapLayout
        )
        collectionView.isSkeletonable = true
        collectionView.showAnimatedSkeleton(
            usingColor: .asbestos,
            transition: .crossDissolve(0.25)
        )
    }
    
    func addConstraintsOfView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func stopSkeleton() {
        collectionView.stopSkeletonAnimation()
        hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
    
}

// MARK: - UICollectionViewDataSource
extension BankTemplateSet: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        return String(describing: BankTemplateCell.self)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return presenter?.getTemplateData().count ?? 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.addCell(BankTemplateCell.self, at: indexPath)
        cell.radiusAndShadow(radius: 10, shadowSize: 10)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let templateData = presenter?.getTemplateData(),
                indexPath.row < templateData.count
        else { return }
        
        if let cell = cell as? BankTemplateCell {
            cell.configure(with: templateData[indexPath.row])
            self.stopSkeleton()
        }
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BankTemplateSet: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = frame.width / 3
        return .init(width: width, height: frame.height - 40)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.userWantToDetails(of: .template, with: indexPath.item)
    }
    
}
