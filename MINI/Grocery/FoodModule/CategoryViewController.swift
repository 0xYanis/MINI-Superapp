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
    }
    
    func createNavigation(with title: String) {
        
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
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
}

