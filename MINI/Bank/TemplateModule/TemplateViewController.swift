//
//  TemplateViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 28.04.2023.
//

import UIKit

protocol TemplateViewProtocol: AnyObject {
    
}

final class TemplateViewController: UIViewController {
    
    var presenter: TemplatePresenterProtocol?
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

extension TemplateViewController: TemplateViewProtocol {
    
}

private extension TemplateViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
        createNavigation(title: "Template")
        createTableView(tableView: tableView)
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func createTableView(tableView: UITableView) {
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDataSource
extension TemplateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row) cell"
        cell.backgroundColor = .clear
        cell.detailTextLabel?.text = "\(indexPath.row)"
        cell.imageView?.image = UIImage(systemName: "note.text")
        return cell
    }
}
