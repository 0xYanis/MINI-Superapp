//
//  TransactionViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit
import SnapKit
import SDWebImage

protocol TransactionViewProtocol: AnyObject {
    func updateView(with data: BankTransactionEntity)
}

final class TransactionViewController: UIViewController {
    
    var presenter: TransactionPresenterProtocol?
    
    private lazy var scrollView = UIScrollView()
    private lazy var imageView  = UIImageView()
    private lazy var tableView  = UITableView(
        frame: .zero,
        style: .grouped
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

extension TransactionViewController: TransactionViewProtocol {
    func updateView(with data: BankTransactionEntity) {
        ///
        guard let image = SDImageCache.shared.imageFromCache(
            forKey: data.icon
        ) else { return }
        imageView.image = image
    }
}

private extension TransactionViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createScrollView()
        createImageView()
       // createTableView()
    }
    
    func createNavigation() {
        navigationItem.title = "Transaction"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createImageView() {
        imageView.contentMode = .scaleAspectFill
        
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    func createTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        tableView.dataSource = self
        
        scrollView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDataSource
extension TransactionViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 30
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row) cell"
        cell.backgroundColor = .clear
        cell.detailTextLabel?.text = "\(indexPath.row)"
        cell.imageView?.image = UIImage(systemName: "note.text")
        return cell
    }
}
