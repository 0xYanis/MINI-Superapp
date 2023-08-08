//
//  AdressViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit
import SnapKit

protocol AdressViewDelegate: AnyObject {
    func userStartSearchAdress(with searchText: String)
    func cancelButtonTapped()
}

final class AdressViewController: UIViewController {
    
    weak var presenter: GroceryPresenterProtocol?
    weak var delegate: AdressViewDelegate?
    
    private lazy var textTilte    = UILabel()
    private lazy var searchBar    = UISearchBar()
    private lazy var tableView    = MiTableView()
    private lazy var cancelButton = UIButton(
        systemImage: "xmark.circle.fill",
        color: .tintMINI,
        size: 35
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
}

//MARK: - Private methods
private extension AdressViewController {
    func initialize() {
        view.backgroundColor = .backMINI
        createTitle(text: "new_adress_title".localized)
        createSearchBar()
        createTableView()
        createCancelButton()
    }
    
    func createTitle(text: String) {
        textTilte.text = text
        textTilte.tintColor = .tintMINI
        textTilte.font = .boldSystemFont(ofSize: 25)
        view.addSubview(textTilte)
        textTilte.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
    }
    
    func createSearchBar() {
        searchBar.backgroundColor = .clear
        searchBar.tintColor = .tintMINI
        searchBar.delegate = self
        searchBar.barTintColor = .backMINI
        searchBar.placeholder = "new_adress_search".localized
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(textTilte.snp.bottom)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    func createTableView() {
        tableView.backgroundColor = .clear
        tableView.rowHeight = 44
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    func createCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(25)
        }
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonAction),
            for: .touchUpInside
        )
    }
    
}

//MARK: - Private action methods
private extension AdressViewController {
    @objc func cancelButtonAction() {
        delegate?.cancelButtonTapped()
    }
    
}

//MARK: - UISearchBarDelegate
extension AdressViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.userStartSearchAdress(with: searchText)
    }
    
}


//MARK: - UITableViewDataSource
extension AdressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let data = presenter?.getSearchAdressesResults() else { return 0 }
        return ( !data.isEmpty ? data.count : 0 )
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let data = presenter?.getSearchAdressesResults() else { return cell }
        cell.backgroundColor = .clear
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension AdressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
