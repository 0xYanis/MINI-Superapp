//
//  GroceryViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit
import SnapKit
import SkeletonView
import FloatingPanel

protocol GroceryViewProtocol: AnyObject {
    func updateView()
    func showLoadingDataGetFailed(with message: String)
}

final class GroceryViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: GroceryPresenterProtocol?
    
    //MARK: Private properties
    private var collectionView: GroceryCollectionView!
    private lazy var panel = FloatingPanelController()
    private lazy var refreshControl = UIRefreshControl()
    private lazy var adressVC = AdressViewController()
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.searchBar.placeholder = "grocery_search".localized
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
    
    func updateView() {
        collectionView.reloadData()
    }
    
    func showLoadingDataGetFailed(with message: String) {
        
    }
    
}

//MARK: - Private methods

private extension GroceryViewController {
    
    func initialize() {
        view.backgroundColor = .secondarySystemBackground
        createNavigation(title: "grocery_navbar".localized)
        createNavigationButtons()
        createCollectionView()
        createRefreshControl()
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func createNavigationButtons() {
        navigationItem.rightBarButtonItem = rightBarAdressButton()
        navigationItem.leftBarButtonItem = leftBarCartButton()
    }
    
    func leftBarCartButton() -> UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(systemName: "cart.fill"),
            style: .plain,
            target: self,
            action: #selector(cartButtonAction)
        )
    }
    
    func rightBarAdressButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(
            title: "adress_button".localized,
            menu: createAdressMenu()
        )
        button.tintColor = .systemOrange
        return button
    }
    
    func createAdressMenu() -> UIMenu {
        let setNew = UIAction(
            title: "set_new_adress".localized,
            image: .init(systemName: "mappin.and.ellipse")) { [weak self] _ in
                self?.showFloatingPanel()
            }
        let getMap = UIAction(
            title: "На карте",
            image: .init(systemName: "map")) { [weak self] _ in
                self?.presenter?.userWantUseMapView()
            }
        return UIMenu(children: [ setNew, getMap ] )
    }
    
    func showFloatingPanel() {
        let address = AdressViewController()
        address.delegate = self
        panel.set(contentViewController: address)
        panel.surfaceView.appearance.cornerRadius = 12
        panel.addPanel(toParent: self, animated: true)
        panel.isRemovalInteractionEnabled = true
    }
    
    func hideFloatingPanel() {
        panel.hide(animated: true) {
            self.panel.view.removeFromSuperview()
            self.panel.removeFromParent()
        }
    }
    
    func createCollectionView() {
        collectionView = GroceryCollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
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
            bottom: 20, right: 16)
        return layout
    }
    
    func createRefreshControl() {
        refreshControl.tintColor = .systemOrange
        refreshControl.addTarget(
            self,
            action: #selector(refreshAction),
            for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
}

//MARK: - Action private methods

private extension GroceryViewController {
    
    @objc func refreshAction() {
        presenter?.updateView()
        refreshControl.endRefreshing()
    }
    
    @objc func cartButtonAction() {
        presenter?.userDidTapCart()
    }
    
}

// MARK: - UISearchResultsUpdating

extension GroceryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
}

// MARK: - AdressViewDelegate

extension GroceryViewController: AdressViewDelegate {
    
    func searchResults() -> [Location] {
        guard let locations = presenter?.getLocationResults()
        else { return [] }
        return locations
    }
    
    func searchAdress(with text: String) {
        presenter?.userStartSearchAdress(with: text)
    }
    
    func didTapResult(with index: Int) {
        presenter?.userDidTapLocation(at: index)
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
    
    func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {
        hideFloatingPanel()
    }
    
    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        hideFloatingPanel()
    }
    
}

