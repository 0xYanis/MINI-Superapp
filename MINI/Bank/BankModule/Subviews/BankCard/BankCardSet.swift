//
//  BankCardSet.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit
import SkeletonView

final class BankCardSet: UITableViewCell, BankTableCellConf {
    
    //MARK: Public properties
    weak var presenter: BankPresenterProtocol?
    
    static let cellId = "BankCardSet"
    
    //MARK: Private properties
    private let snapLayout = StackFlowLayout()
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.decelerationRate = .fast
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .clear
            collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
            collectionView.register(
                BankCardCell.self,
                forCellWithReuseIdentifier: String(describing: BankCardCell.self)
            )
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
}

//MARK: - Private methods
private extension BankCardSet {
    func initialize() {
        backgroundColor = .clear
        createCollectionView()
        addConstraintsOfView()
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: snapLayout
        )
    }
    
    func addConstraintsOfView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.isSkeletonable = true
        collectionView.showAnimatedSkeleton(
            usingColor: .asbestos,
            transition: .crossDissolve(0.25)
        )
    }
    
    func stopSkeleton() {
        collectionView.stopSkeletonAnimation()
        hideSkeleton(
            reloadDataAfter: true,
            transition: .crossDissolve(0.25)
        )
    }
    
}

// MARK: - SkeletonCollectionViewDataSource
extension BankCardSet: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        return String(describing: BankCardCell.self)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return presenter?.getCardData().count ?? 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return collectionView.addCell(BankCardCell.self, at: indexPath)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cardData = presenter?.getCardData(),
              indexPath.row < cardData.count else { return }
        
        if let cell = cell as? BankCardCell {
            cell.shadow(color: .black, opacity: 0.5, radius: 10)
            cell.configure(with: cardData[indexPath.row])
            self.stopSkeleton()
        }
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemsAt indexPaths: [IndexPath],
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        
        guard indexPaths.count == 1,
              let indexPath = indexPaths.first else { return nil }
        
        let editAction   = editCellsAction(collectionView, indexPath: indexPath)
        let deleteAction = deleteCellsAction(collectionView, indexPath: indexPath)
        
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in
            UIMenu(
                title: "",
                children: [editAction, deleteAction]
            )
        }
    }
    
    func editCellsAction(_ collectionView: UICollectionView, indexPath: IndexPath) -> UIAction {
        let editAction = UIAction(
            title: "Изменить",
            image: UIImage(systemName: "square.and.pencil"),
            attributes: []
        ) { [weak self] _ in
            self?.presenter?.userWantToDetails(of: .card, with: indexPath.item)
        }
        
        return editAction
    }
    
    func deleteCellsAction(_ collectionView: UICollectionView, indexPath: IndexPath) -> UIAction {
        let deleteAction = UIAction(
            title: "Удалить",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.presenter?.userWantToDeleteCard(at: indexPath.item)
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [indexPath])
            })
        }
        
        return deleteAction
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension BankCardSet: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 16
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = frame.width / 2.5
        return .init(width: width, height: frame.height-40)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.userWantToDetails(of: .card, with: indexPath.item)
    }
    
}
