//
//  GroceryViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit
import SnapKit
import SkeletonView

protocol GroceryViewProtocol: AnyObject {
    
}

final class GroceryViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: GroceryPresenterProtocol?
    
    
    //MARK: Private properties
    private var collectionView: UICollectionView!
    private lazy var refreshControl = UIRefreshControl()
    private lazy var adressVC = AdressViewController()
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: UIViewController())
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search for groceries"
        controller.searchBar.delegate = self
        controller.searchBar.tintColor = .systemOrange
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
    
}

//MARK: - GroceryViewProtocol
extension GroceryViewController: GroceryViewProtocol {
    
}

//MARK: - Private methods
private extension GroceryViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation(title: "Grocery store")
        createNavigationButtons(adress: "22 Washington st. NY")
        createCollectionView()
        collectionViewRegistrate()
        createRefreshControl()
        collectionViewWithSkeleton()
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func createNavigationButtons(adress: String) {
        navigationItem.rightBarButtonItem = rightBarAdressButton(adress: adress)
    }
    
    func rightBarAdressButton(adress: String) -> UIBarButtonItem {
        let button = UIBarButtonItem(
            title: "Adress",
            menu: createAdressMenu(adress: adress)
        )
        button.tintColor = .systemOrange
        return button
    }
    
    func createAdressMenu(adress: String) -> UIMenu {
        let adress = UIAction(title: adress) { _ in
            //
        }
        let setNewImage = UIImage(systemName: "mappin.and.ellipse")
        let setNew = UIAction(
            title: "Set new Adress",
            image: setNewImage) { [weak self] _ in
                self?.showAdressButtonSheet()
            }
        return UIMenu(children: [ setNew, adress ] )
    }
    
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 16, bottom: 20, right: 16)
        return layout
    }
    
    func collectionViewRegistrate() {
        collectionView.register(
            GroceryViewCell.self,
            forCellWithReuseIdentifier: GroceryViewCell.cellId
        )
        collectionView.register(
            GroceryHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: GroceryHeaderCell.cellId
        )
    }
    
    func createRefreshControl() {
        refreshControl.tintColor = .systemOrange
        refreshControl.addTarget(
            self,
            action: #selector(refreshAction),
            for: .valueChanged
        )
        collectionView.refreshControl = refreshControl
    }
    
    func createAdressBottomSheet(multiply: CGFloat) {
        adressVC.delegate = self
        let height = view.frame.height * multiply
        let smallId = UISheetPresentationController.Detent.Identifier("smallId")
        let small = UISheetPresentationController.Detent.custom(identifier: smallId) { _ in
            return height
        }
        adressVC.isModalInPresentation = true
        if let sheet = adressVC.sheetPresentationController {
            sheet.detents = [ small ]
            sheet.preferredCornerRadius = 30
        }
        present(adressVC, animated: true)
    }
    
    func collectionViewWithSkeleton() {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedSkeleton(
            usingColor: .asbestos,
            transition: .crossDissolve(0.25)
        )
    }
    
    func stopSkeleton() {
        collectionView.stopSkeletonAnimation()
        view.hideSkeleton(
            reloadDataAfter: true,
            transition: .crossDissolve(0.25)
        )
    }
    
}

//MARK: - Action private methods
private extension GroceryViewController {
    @objc func refreshAction() {
        presenter?.updateView()
        refreshControl.endRefreshing()
    }
    
    func showAdressButtonSheet() {
        createAdressBottomSheet(multiply: 0.3)
    }
}

//MARK: - AdressViewDelegate
extension GroceryViewController: AdressViewDelegate {
    func userStartSearchAdress(with searchText: String) {
        
    }
    
    func cancelButtonTapped() {
        dismiss(animated: true)
    }
}


//MARK: - UISearchBarDelegate
extension GroceryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        
    }
}

//MARK: - UISearchResultsUpdating
extension GroceryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

//MARK: - UICollectionViewDataSource
extension GroceryViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        GroceryViewCell.cellId
    }
    
    func numberOfSections(in collectionView: UICollectionView
    ) -> Int {
        presenter?.getGroceryData().count ?? 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter?.getGroceryData()[section].count ?? 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GroceryViewCell.cellId,
            for: indexPath) as? GroceryViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let data = presenter?.getGroceryData()[indexPath.section],
        indexPath.row < data.count else { return }
                
        if let cell = cell as? GroceryViewCell {
            cell.roundCorners(radius: 12)
            cell.configure(with: data[indexPath.row])
        }
        
        self.stopSkeleton()
    }
    
}

//MARK: - Header titles for sections
extension GroceryViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: GroceryHeaderCell.cellId,
            for: indexPath
        ) as? GroceryHeaderCell else {
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
extension GroceryViewController: UICollectionViewDelegateFlowLayout {
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
        presenter?.userDidTapDetailCategory(id: indexPath.item)
    }
}
