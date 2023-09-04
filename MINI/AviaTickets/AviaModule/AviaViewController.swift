//
//  AviaViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import UIKit
import SnapKit

protocol AviaViewProtocol: AnyObject {
    func updateView()
    func loadingDataGetFailed(with error: String)
}

final class AviaViewController: UIViewController {
    
    //MARK: - Public properties
    
    var presenter: AviaPresenterProtocol?
    
    //MARK: - Private properties
    
    private lazy var refreshControl   = UIRefreshControl()
    private lazy var searchController = UISearchController()
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            collectionView.dataSource = self
            collectionView.register(
                UICollectionViewCell.self,
                forCellWithReuseIdentifier: "cell"
            )
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
}

//MARK: - AviaViewProtocol

extension AviaViewController: AviaViewProtocol {
    
    func updateView() {
        
    }
    
    func loadingDataGetFailed(with error: String) {
        
    }
    
}

//MARK: - Private methods

private extension AviaViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        createNavigation()
        createSearchController()
        createCollectionView()
        createRefreshControl(scrollView: collectionView)
    }
    
    func createNavigation() {
        navigationItem.searchController = searchController
        navigationItem.title = "tickets_navbar".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createSearchController() {
        
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createRefreshControl(scrollView: UIScrollView) {
        refreshControl.addTarget(
            self,
            action: #selector(refreshAction),
            for: .valueChanged
        )
        scrollView.refreshControl = refreshControl
    }
    
}

// MARK: - Action methods

private extension AviaViewController {
    
    @objc func refreshAction() {
        refreshControl.endRefreshing()
    }
    
}

// MARK: - UICollectionViewDataSource

extension AviaViewController: UICollectionViewDataSource {
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0: return 1
        case 1: return 4
        case 2: return 1
        case 3: return 8
        case 5: return 1
        default: return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        )
        cell.backgroundColor = .red
        return cell
    }
    
}
