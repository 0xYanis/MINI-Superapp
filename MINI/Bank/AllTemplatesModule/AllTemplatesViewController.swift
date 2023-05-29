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
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createCollectionView()
        collectionViewRegistrate()
    }
    
    func createNavigation() {
        navigationItem.title = "all_templates_navbar".localized
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func createCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        templateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
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
            AllTemplatesViewCell.self, forCellWithReuseIdentifier: AllTemplatesViewCell.cellId
        )
    }
}

// MARK: - UICollectionViewDataSource
extension AllTemplatesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
                        section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                        indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllTemplatesViewCell.cellId, for: indexPath
        ) as? AllTemplatesViewCell else { return defaultCell }
        
        return cell
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
