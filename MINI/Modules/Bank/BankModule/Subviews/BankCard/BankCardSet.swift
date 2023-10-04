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
    public var valueIsHidden: Bool = false
    
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
            collectionView.register(BankCardCell.self, forCellWithReuseIdentifier: String(describing: BankCardCell.self))
            collectionView.register(BankEmptyCardCell.self, forCellWithReuseIdentifier: String(describing: BankEmptyCardCell.self))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
    
}

//MARK: - Private methods
private extension BankCardSet {
    
    func initialize() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: snapLayout)
        backgroundColor = .clear
        addConstraintsOfView()
    }
    
    func addConstraintsOfView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.isSkeletonable = true
        collectionView.showAnimatedSkeleton(
            usingColor: .asbestos,
            transition: .crossDissolve(0.25))
    }
    
    func stopSkeleton() {
        collectionView.stopSkeletonAnimation()
        hideSkeleton(
            reloadDataAfter: true,
            transition: .crossDissolve(0.25))
    }
    
}

// MARK: - SkeletonCollectionViewDataSource

extension BankCardSet: SkeletonCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
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
        if section == 0 {
            return presenter?.getCardData().count ?? 5
        } else {
            return 1
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.addCell(BankCardCell.self, at: indexPath)
            cell.valueIsHidden = self.valueIsHidden
            return cell
        } else {
            return collectionView.addCell(BankEmptyCardCell.self, at: indexPath)
        }
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
        guard
            indexPaths.count == 1,
            let indexPath = indexPaths.first
        else { return nil }
        let openAction   = openCellsAction(indexPath: indexPath)
        let updateAction = updateCellsAction(indexPath: indexPath)
        let deleteAction = deleteCellsAction(collectionView, indexPath: indexPath)
        let context = createContextMenu(indexPath, menu: [openAction, updateAction, deleteAction])
        
        return context
    }
    
    private func createContextMenu(
        _ indexPath: IndexPath,
        menu: [UIMenuElement]
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration { [weak self] () -> UIViewController? in
            guard
                let self = self,
                let data = self.presenter?.getCardData()[indexPath.row]
            else { return nil }
            let preview = CardBuilder.build(with: data)
            return preview
        } actionProvider: { _ in
            UIMenu(title: "Выберите действие", children: menu)
        }
    }
    
    private func openCellsAction(indexPath: IndexPath) -> UIAction {
        return UIAction(
            title: "Открыть",
            image: UIImage(systemName: "creditcard"),
            attributes: []
        ) { [weak self] _ in
            self?.presenter?.userWantToDetails(of: .card, with: indexPath.item)
        }
    }
    
    private func updateCellsAction(indexPath: IndexPath) -> UIAction {
        return UIAction(
            title: "Изменить",
            image: UIImage(systemName: "square.and.pencil"),
            attributes: []
        ) { [weak self] _ in
            self?.presenter?.userWantToDetails(of: .card, with: indexPath.item)
        }
    }
    
    private func deleteCellsAction(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UIAction {
        return UIAction(
            title: "Удалить",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.presenter?.userWantToDeleteCard(at: indexPath.item)
            collectionView.performBatchUpdates {
                collectionView.deleteItems(at: [indexPath])
            }
        }
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
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if section == 1 { return .init(top: 0, left: 16, bottom: 0, right: 0) }
        return .zero
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
        if indexPath.section == 0 {
            presenter?.userWantToDetails(of: .card, with: indexPath.item)
        } else {
            presenter?.userWantToDetails(of: .newCard, with: 0)
        }
    }
    
}
