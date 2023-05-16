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
    
    weak var delegate: AdressViewDelegate?
    
    private lazy var textTilte    = UILabel()
    private lazy var searchBar    = UISearchBar()
    private lazy var tableView    = UITableView()
    private lazy var cancelButton = UIButton(
        systemImage: "xmark.circle.fill",
        color: .systemOrange,
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
        view.backgroundColor = .black
        createTitle(text: "New adress")
        createSearchBar()
        createTableView()
        createCancelButton()
    }
    
    func createTitle(text: String) {
        textTilte.text = text
        textTilte.tintColor = .white
        textTilte.font = .boldSystemFont(ofSize: 25)
        view.addSubview(textTilte)
        textTilte.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
    }
    
    func createSearchBar() {
        searchBar.tintColor = .systemOrange
        searchBar.delegate = self
        searchBar.barTintColor = .clear
        searchBar.placeholder = "Search your adress.."
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
        return 3
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.text = "This is a \(indexPath.row) cell"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AdressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
}
