//
//  AllTemplatesViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit
import SnapKit

protocol AllTemplatesViewProtocol: AnyObject {
    func viewDidLoaded(data: TemplateEntity)
    func userWantToDeleteTemplate(id: Int)
}

final class AllTemplatesViewController: UIViewController {
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
    
    //MARK: - private properties
    private var templateCollectionView: UICollectionView!
}

//MARK: - AllTemplatesViewProtocol
extension AllTemplatesViewController: AllTemplatesViewProtocol {
    func viewDidLoaded(data: TemplateEntity) {
        
    }
    
    func userWantToDeleteTemplate(id: Int) {
        presenter?.userWillDeleteTemplate(id: id)
    }
}

//MARK: - Private methods
private extension AllTemplatesViewController {
    func initialize() {
        view.backgroundColor = .white
        createNavigation()
        createCollectionView()
        collectionViewRegistrate()
    }
    
    func createNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "All Templates"
    }
    
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        templateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        templateCollectionView.delegate = self
        templateCollectionView.dataSource = self
        view.addSubview(templateCollectionView)
        templateCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        templateCollectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
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
                        collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt
                        section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.userDidTapTemplate(id: indexPath.item)
    }
}
