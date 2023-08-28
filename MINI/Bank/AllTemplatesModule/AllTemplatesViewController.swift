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
    private var templateCollectionView: UICollectionView! {
        didSet {
            templateCollectionView.delegate = self
            templateCollectionView.dataSource = self
            templateCollectionView.backgroundColor = .clear
        }
    }
    
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
        view.backgroundColor = .back2MINI
        createNavigation()
        createCollectionView()
        collectionViewRegistrate()
    }
    
    func createNavigation() {
        navigationItem.title = "all_templates_navbar".localized
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [AddBtton]
    }
    
    var AddBtton: UIBarButtonItem {
        return UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addAction)
        )
    }
    
    @objc func editAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = templateCollectionView.indexPathForItem(at: gesture.location(in: templateCollectionView)) else { return }
            templateCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            templateCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            templateCollectionView.endInteractiveMovement()
        default:
            templateCollectionView.cancelInteractiveMovement()
        }
    }
    
    @objc func addAction() {
        presenter?.userDidTapAddNew()
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
        createLongPressGesture()
        
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
    
    func createLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(editAction)
        )
        templateCollectionView.addGestureRecognizer(longPress)
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
        return collectionView.addCell(AllTemplatesViewCell.self, at: indexPath)
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
