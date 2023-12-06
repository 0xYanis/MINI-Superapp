//
//  AdressViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit
import SnapKit

// MARK: - AdressViewDelegate

protocol AdressViewDelegate: AnyObject {
    func searchAdress(with text: String)
    func didTapResult(with index: Int)
}

final class AdressViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: AdressViewDelegate?
    
    // MARK: - Private properties
    
    private let label     = UILabel()
    private let textField = UITextField()
    private lazy var tableView = MiTableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(tableView)
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSizes()
    }
    
    // MARK: - Public methods
    
    public func configure(label: String, placeholder: String) {
        self.label.text = label
        self.textField.placeholder = placeholder
    }
    
    public func updateView() {
        tableView.reloadData()
    }
    
}

// MARK: - Private methods

private extension AdressViewController {
    
    func initialize() {
        createLabel()
        createTextField()
        createTableView()
    }
    
    func createLabel() {
        label.text = "Введите адрес"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    func createTextField() {
        textField.placeholder = "Enter destination"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .tertiarySystemBackground
        textField.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.delegate = self
    }
    
    func createTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self)
    }
    
    func configureSizes() {
        label.sizeToFit()
        
        label.frame = CGRect(
            x: 16, y: 15,
            width: label.frame.size.width,
            height: label.frame.size.height)
        
        textField.frame = CGRect(
            x: 16, y: 30 + label.frame.size.height,
            width: view.frame.size.width - 35,
            height: 36)
        
        let tableY: CGFloat = textField.frame.origin.y + textField.frame.size.height + 20
        tableView.frame = .init(
            x: 0, y: tableY,
            width: view.frame.size.width,
            height: view.frame.size.height - tableY)
    }
    
}

// MARK: - UITextFieldDelegate

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

// MARK: - UITableViewDataSource

extension AdressViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath
        )
        let title = ""
        cell.textLabel?.text = title
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension AdressViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapResult(with: indexPath.row)
    }
    
}
