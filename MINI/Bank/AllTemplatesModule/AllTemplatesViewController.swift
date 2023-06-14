//
//  AllTemplatesViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit
import SnapKit

protocol AllTemplatesViewProtocol: AnyObject {
    func viewDidLoaded(data: AllTemplatesEntity)
    func userWantToDeleteTemplate(id: Int)
}

final class AllTemplatesViewController: UIViewController {
    
    //MARK: - Private properties
    private var templateCollectionView: UICollectionView!
    
    //MARK: - Public properties
    var presenter: AllTemplatesPresenterProtocol?
    
    //MARK: - public methdods
    func configure() {
        
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

//MARK: - AllTemplatesViewProtocol
extension AllTemplatesViewController: AllTemplatesViewProtocol {
    func viewDidLoaded(data: AllTemplatesEntity) {
        
    }
    
    func userWantToDeleteTemplate(id: Int) {
        presenter?.userWillDeleteTemplate(id: id)
    }
}

//MARK: - Private methods
private extension AllTemplatesViewController {
    func initialize() {
        view.backgroundColor = .init(white: 0.05, alpha: 1.0)
        createNavigation()
        createCollectionView()
        collectionViewRegistrate()
    }
    
    func createNavigation() {
        navigationItem.title = "all_templates_navbar".localized
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [editButon, AddBtton]
    }
    
    var editButon: UIBarButtonItem {
        return UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(editAction)
        )
    }
    
    var AddBtton: UIBarButtonItem {
        return UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addAction)
        )
    }
    
    @objc func editAction() {
        
    }
    
    @objc func addAction() {
        
    }
    
    
    var layout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return flowLayout
    }
    
    func createCollectionView() {
        templateCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        templateCollectionView.delegate = self
        templateCollectionView.dataSource = self
        templateCollectionView.backgroundColor = .clear
        
        view.addSubview(templateCollectionView)
        templateCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionViewRegistrate() {
        templateCollectionView.register(
            AllTemplatesViewCell.self,
            forCellWithReuseIdentifier: AllTemplatesViewCell.cellId
        )
    }
}

// MARK: - UICollectionViewDataSource
extension AllTemplatesViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter?.getTemplatesData().count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllTemplatesViewCell.cellId, for: indexPath
        ) as? AllTemplatesViewCell else { return defaultCell }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let data = presenter?.getTemplatesData()[indexPath.item] else { return }
        if let cell = cell as? AllTemplatesViewCell {
            cell.configure(name: data.label, image: data.image)
        }
    }
    
    
    // Context Menu
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemsAt indexPaths: [IndexPath],
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard indexPaths.count == 1,
              let indexPath = indexPaths.first else { return nil }
        
        let deleteAction = deleteCellsAction(collectionView, indexPath: indexPath)
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in
            UIMenu(
                title: "",
                children: [deleteAction]
            )
        }
    }
    
    func deleteCellsAction(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UIAction {
        let deleteAction = UIAction(
            title: "Удалить",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.presenter?.userWillDeleteTemplate(id: indexPath.item)
            collectionView.performBatchUpdates {
                collectionView.deleteItems(at: [indexPath])
            }
        }
        
        return deleteAction
    }
    
    // Move Item
    func collectionView(
        _ collectionView: UICollectionView,
        canMoveItemAt indexPath: IndexPath
    ) -> Bool {
        true
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        moveItemAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        let from = sourceIndexPath.item
        let to = destinationIndexPath.item
        presenter?.userWillMoveTemplate(from: from, to: to)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AllTemplatesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                        indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 16
        let width = (collectionView.bounds.width - itemSpacing * 3) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.userDidTapTemplate(id: indexPath.item)
    }
}
