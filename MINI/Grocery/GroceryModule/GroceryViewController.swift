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
    
    let dataText = "Для создания динамического размера ячейки в UITableView с использованием SnapKit необходимо выполнить следующие шаги: 1. Установить свойство `tableView.estimatedRowHeight` равным некоторому приблизительному значению высоты ячейки, например, 150. ```swift tableView.estimatedRowHeight = 150 ``` 2. В методе `tableView(_:cellForRowAt:)` установить свойство `cell.textLabel?.numberOfLines` равным нулю, чтобы многострочный текст в ячейке отображался корректно.```swift cell.textLabel?.numberOfLines = 0 ```"
    
    //MARK: Public properties
    var presenter: GroceryPresenterProtocol?
    
    
    //MARK: Private properties
    private lazy var tableView = UITableView()
    private lazy var refreshControl = UIRefreshControl()
    private lazy var searchController = GrocerySearchController()
    private lazy var adressVC = AdressViewController()
    
    
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
        createNavigation(title: "Grocery Store")
        createNavigationButtons(adress: "22 Washington st. NY")
        createTableView()
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
    
    func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createRefreshControl() {
        refreshControl.tintColor = .systemOrange
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func createAdressBottomSheet() {
        adressVC.delegate = self
        let height = view.frame.height * 0.3
        let smallId = UISheetPresentationController.Detent.Identifier("smallId")
        let small = UISheetPresentationController.Detent.custom(identifier: smallId) { _ in
            return height
        }
        adressVC.isModalInPresentation = true
        if let sheet = adressVC.sheetPresentationController {
            sheet.largestUndimmedDetentIdentifier = smallId
            sheet.detents = [ small ]
            sheet.preferredCornerRadius = 30
            //TODO: - добавить затенение заднего фона (сделать его неактивным)
        }
        navigationController?.present(adressVC, animated: true)
    }
    
    
}

//MARK: - Action private methods
private extension GroceryViewController {
    @objc func refreshAction() {
        presenter?.updateView()
        refreshControl.endRefreshing()
    }
    
    func showAdressButtonSheet() {
        createAdressBottomSheet()
    }
}

extension GroceryViewController: AdressViewDelegate {
    func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
}

//MARK: - UITableViewDataSource
extension GroceryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataText
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate
extension GroceryViewController: UITableViewDelegate {
    
}

