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
        
    }
    
    func loadingDataGetFailed(with error: String) {
        
    }
    
}

//MARK: - Private methods

private extension AviaViewController {
    
    func initialize() {
        createNavigation()
        view.backgroundColor = .back2MINI
        
        aviaCollectionView.presenter = presenter
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
    
}
