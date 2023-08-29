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
    func updateView()
    func showLoadingDataGetFailed(with message: String)
}

final class GroceryViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: GroceryPresenterProtocol?
    
    //MARK: Private properties
    private var collectionView: GroceryCollectionView!
    private lazy var refreshControl = UIRefreshControl()
    private lazy var adressVC = AdressViewController()
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "grocery_search".localized
        return controller
    }()
    private lazy var cartButton: UIButton = {
        let butt = UIButton(systemImage: "cart.fill", color: .tintMINI, size: 50)
        butt.addTarget(
            self,
            action: #selector(cartButtonAction),
            for: .touchUpInside
        )
        return butt
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
    func updateView() {
        collectionView.reloadData()
    }
    
    func showLoadingDataGetFailed(with message: String) {
        
    }
    
}

//MARK: - Private methods
private extension GroceryViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
        createNavigation(title: "grocery_navbar".localized)
        createNavigationButtons(adress: "22 Washington st. NY")
        createCollectionView()
        createRefreshControl()
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cartButton)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func createNavigationButtons(adress: String) {
        navigationItem.rightBarButtonItem = rightBarAdressButton(adress: adress)
    }
    
    func rightBarAdressButton(adress: String) -> UIBarButtonItem {
        let button = UIBarButtonItem(
            title: "adress_button".localized,
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
            title: "set_new_adress".localized,
            image: setNewImage) { [weak self] _ in
                self?.showAdressButtonSheet()
            }
        let getMapImage = UIImage(systemName: "map")
        let getMap = UIAction(
            title: "На карте",
            image: getMapImage) { [weak self] _ in
                self?.presenter?.userWantUseMapView()
            }
        return UIMenu(children: [ setNew, adress, getMap ] )
    }
    
    
    func createCollectionView() {
        collectionView = GroceryCollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.delegate = self
        collectionView.presenter = presenter
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
        layout.sectionInset = UIEdgeInsets(
            top: 5, left: 16,
            bottom: 20, right: 16
        )
        return layout
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
        adressVC.presenter = presenter
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
    
    @objc func cartButtonAction() {
        presenter?.userDidTapCart()
    }
    
}

//MARK: - AdressViewDelegate
extension GroceryViewController: AdressViewDelegate {
    func userStartSearchAdress(with searchText: String) {
        presenter?.userStartSearchAdress(with: searchText)
    }
    
    func cancelButtonTapped() {
        dismiss(animated: true)
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
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        .init(width: view.frame.width, height: 35)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.userDidTapDetailCategory(id: indexPath.item)
    }
    
}

