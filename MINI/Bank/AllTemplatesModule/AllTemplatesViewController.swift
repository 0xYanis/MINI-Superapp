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
    private let templateCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    )
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
        createCollectionView()
        collectionViewRegistrate()
    }
    
    func createCollectionView() {
        templateCollectionView.delegate = self
        templateCollectionView.dataSource = self
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
                        collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt
                        section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height / 6
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.userDidTapTemplate(id: indexPath.item)
    }
}
