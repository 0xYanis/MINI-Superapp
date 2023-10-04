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
    func updateCart(with totalCost: Double)
}

final class CategoryViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: CategoryPresenterProtocol?
    
    //MARK: Private properties
    private lazy var cartView = CategoryCartView()
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            collectionView.showsVerticalScrollIndicator = false
            collectionView.delegate = self
            collectionView.dataSource = self
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cartViewScrollAppearance(collectionView, inset: -100, alpha: 0.0)
    }
    
}

//MARK: - CategoryViewProtocol
extension CategoryViewController: CategoryViewProtocol {
    func udateView() {
        createNavigation(with: "Food")
    }
    
    func updateCart(with totalCost: Double) {
        if totalCost == 0.0 {
            cartView.isHidden = true
        } else {
            cartView.isHidden = false
            cartView.configure(with: "\(totalCost)")
        }
    }
    
}

//MARK: - Private methods
private extension CategoryViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
        createCartView()
        createCollectionView()
    }
    
    func createNavigation(with title: String) {
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = rightButton
    }
    
    var rightButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
    
    func createCartView() {
        cartView.radiusAndShadow(radius: 30, opacity: 1.0, shadowSize: 30)
        view.insertSubview(cartView, at: 1)
        cartView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.075)
        }
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCart)
        )
        cartView.addGestureRecognizer(tapGesture)
        cartView.isHidden = true
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        
        createConstraints()
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(
            top: 5, left: 16,
            bottom: 50, right: 16
        )
        return layout
    }
    
    func createConstraints() {
        view.insertSubview(collectionView, at: 0)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}


private extension CategoryViewController {
    @objc func searchButtonTapped() {
        presenter?.userDidTapSearchProduct()
    }
    
    @objc func priceButtonAction(_ sender: UIButton) {
        if let cell = sender.superview as? CategoryCell,
           let index = collectionView.indexPath(for: cell) {
            cell.isAddedToCart.toggle()
            cell.updateButton()
            print("Секция\(index.section), ячейка №\(index.item)")
            presenter?.userAddProductToCart(
                section: index.section,
                index: index.item
            )
        }
    }
    
    
    @objc func didTapCart() {
        presenter?.userDidTapCart()
    }
    
    func cartViewScrollAppearance(_ scrollView: UIScrollView, inset: CGFloat, alpha: CGFloat) {
        if scrollView == collectionView {
            cartView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(inset)
                make.centerX.equalToSuperview()
                make.left.right.equalToSuperview().inset(20)
                make.height.equalToSuperview().multipliedBy(0.075)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
                self.cartView.alpha = alpha
            }
        }
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
        cell.priceButton.tag = indexPath.item
        cell.priceButton.addTarget(
            self,
            action: #selector(priceButtonAction),
            for: .touchUpInside
        )
        
        return cell
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        
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
        let width = (collectionView.bounds.width - itemSpacing * 3) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.userDidTapProduct(index: indexPath.item)
    }
    
}

extension CategoryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cartViewScrollAppearance(
            scrollView,
            inset: -100,
            alpha: 0.0
        )
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        cartViewScrollAppearance(
            scrollView,
            inset: 30,
            alpha: 1.0
        )
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        cartViewScrollAppearance(
            scrollView,
            inset: 30,
            alpha: 1.0
        )
    }
    
}

