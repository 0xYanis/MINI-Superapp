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
    
    let data: [[String]] = [["Apple"], ["Grapes", "Kiwi"], ["Orange", "Pineapple", "Strawberry","Orange"], ["Pear"]]
    
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
        initialize()
        presenter?.viewDidLoaded()
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
    
    var flowLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }
    
    func collectionViewRegistrate() {
        collectionView.register(
            GroceryViewCell.self,
            forCellWithReuseIdentifier: GroceryViewCell.cellId
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

//MARK: - UISearchResultsUpdating
extension GroceryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView
    ) -> Int {
        return data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data[section].count
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
    
}

//MARK: - UISearchResultsUpdating
extension GroceryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath
    ) -> CGSize {
        let itemSpacing: CGFloat = 16
        let width = (collectionView.bounds.width - itemSpacing * 3) / 3
        let height = width * 1.3
        return CGSize(width: width, height: width)
    }
}
