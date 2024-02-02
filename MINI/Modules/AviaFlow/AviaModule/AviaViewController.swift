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
    
    private let refreshControl = UIRefreshControl()
    private var aviaCollectionView: AviaCollectionView = {
        let layout = UICollectionViewLayout()
        let view = AviaCollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
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
        aviaCollectionView.reloadData()
    }
    
    func loadingDataGetFailed(with error: String) {
        
    }
    
}

//MARK: - AviaSearchViewDelegate

extension AviaViewController: AviaSearchViewDelegate {
    
    func set(location: String?,_ state: AviaLocationState) {
        
    }
    
    func didTapDatePicker() {
        present(DateViewController.modalDate, animated: true)
    }
    
    func showSearchResults() {
        
    }
    
}

//MARK: - Private methods

private extension AviaViewController {
    
    func initialize() {
        createNavigation()
        view.backgroundColor = .back2MINI
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        aviaCollectionView.refreshControl = refreshControl
        
        aviaCollectionView.presenter = presenter
        aviaCollectionView.aviaDelegate = self
        view.addSubview(aviaCollectionView)
        addConstraints()
    }
    
    func createNavigation() {
        navigationItem.title = "tickets_navbar".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addConstraints() {
        aviaCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func refreshAction() {
        refreshControl.endRefreshing()
    }
    
}
