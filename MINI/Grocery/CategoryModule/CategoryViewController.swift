//
//  CategoryViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import UIKit
import SnapKit

protocol CategoryViewProtocol: AnyObject {
    func udateView()
}

final class CategoryViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: CategoryPresenterProtocol?
    
    //MARK: Private properties
    private var collectionView: UICollectionView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

//MARK: - CategoryViewProtocol
extension CategoryViewController: CategoryViewProtocol {
    func udateView() {
        createNavigation(with: "Food")
    }
}

//MARK: - Private methods
private extension CategoryViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createCollectionView()
    }
    
    func createNavigation(with title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        createConstraints()
        collectionViewRegistrate()
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(
            top: 5, left: 16,
            bottom: 20, right: 16
        )
        return layout
    }
    
    func createConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionViewRegistrate() {
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.cellId
        )
        collectionView.register(
            CategoryHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeader.cellId
        )
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView
    ) -> Int {
        4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.cellId,
            for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if let cell = cell as? CategoryCell {
            cell.roundCorners(radius: 12)
        }
    }
    
}

//MARK: - Header titles for sections
extension CategoryViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CategoryHeader.cellId,
            for: indexPath
        ) as? CategoryHeader else {
            return UICollectionReusableView()
        }
        view.configure(with: "Category")
        return view
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        .init(width: view.frame.width, height: 35)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath
    ) -> CGSize {
        let itemSpacing: CGFloat = 16
        let width = (collectionView.bounds.width - itemSpacing * 3) / 3
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.userDidTapProduct(index: indexPath.item)
    }
}
