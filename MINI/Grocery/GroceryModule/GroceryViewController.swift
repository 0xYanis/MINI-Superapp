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
    
    let data: [[Int]] = [[1,2,3],[1,2,3,4,5,6],[1],[1,2],[1,2,3,4],[1,2,3,4,5],[1,2,3,4,5,6,7,8,9]]
    
    //MARK: Public properties
    var presenter: GroceryPresenterProtocol?
    
    
    //MARK: Private properties
    private lazy var tableView = UITableView()
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
        createTableView()
        createRefreshControl()
        tableViewRegistrate()
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
    
    
    func createTableView() {
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100
        tableView.separatorInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableViewRegistrate() {
        tableView.register(
            GroceryViewSet.self,
            forCellReuseIdentifier: GroceryViewSet.cellId
        )
    }
    
    
    func createRefreshControl() {
        refreshControl.tintColor = .systemOrange
        refreshControl.addTarget(
            self,
            action: #selector(refreshAction),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
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

//MARK: - UITableViewDataSource
extension GroceryViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return data.count
    }
    
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroceryViewSet.cellId,
            for: indexPath
        ) as? GroceryViewSet else {
            return UITableViewCell()
        }
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension GroceryViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        let sectionData = data[indexPath.row]
        switch sectionData.count {
        case 1...3:
            return 250
        case 4...6:
            return 500
        case 7...9:
            return 1000
        default:
            return 0
        }
    }
}
