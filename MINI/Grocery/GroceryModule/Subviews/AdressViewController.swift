//
//  AdressViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit
import SnapKit

protocol AdressViewDelegate: AnyObject {
    func searchResults() -> [Location]
    func searchAdress(with text: String)
    func didTapResult(with index: Int)
}

final class AdressViewController: UIViewController {
    
    weak var delegate: AdressViewDelegate?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Введите адрес"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter destination"
        field.layer.cornerRadius = 10
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.delegate = self
        return field
    }()
    
    private lazy var tableView: MiTableView = {
        let table = MiTableView()
        table.register(
            UITableViewCell.self,
            cellId: String(describing: UITableViewCell.self)
        )
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(
            x: 16, y: 15,
            width: label.frame.size.width,
            height: label.frame.size.height)
        textField.frame = CGRect(
            x: 16, y: 20+label.frame.size.height,
            width: view.frame.size.width - 35,
            height: 36)
        let tableY: CGFloat = textField.frame.origin.y + textField.frame.size.height + 20
        tableView.frame = .init(
            x: 0, y: tableY,
            width: view.frame.size.width,
            height: view.frame.size.height - tableY)
    }
    
    public func configure(label: String, placeholder: String) {
        self.label.text = label
        self.textField.placeholder = placeholder
    }
    
}

extension AdressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            delegate?.searchAdress(with: text)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return true
    }
    
}

extension AdressViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return delegate?.searchResults().count ?? 0
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath
        )
        let title = delegate?.searchResults()[indexPath.row].title
        cell.textLabel?.text = title
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
    
}

extension AdressViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapResult(with: indexPath.row)
    }
    
}
