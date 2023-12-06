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
    
    var addressList: [LocalSearchResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        tableView.register(AddressResultCell.self)
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
        addressList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: AddressResultCell.self),
            for: indexPath) as? AddressResultCell
        else { return UITableViewCell() }
        let address = addressList[indexPath.row]
        cell.configure(title: address.title, subtitle: address.subtitle)
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
}

class AddressResultCell: UITableViewCell {
    
    private var titleTextLabel = UILabel()
    private var subtitleTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(title: String, subtitle: String) {
        titleTextLabel.text = title
        subtitleTextLabel.text = subtitle
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        titleTextLabel.font = .systemFont(ofSize: UIFont.labelFontSize)
        titleTextLabel.numberOfLines = 0
        subtitleTextLabel.font = .systemFont(ofSize: UIFont.systemFontSize)
        subtitleTextLabel.numberOfLines = 0
        subtitleTextLabel.textColor = .secondaryLabel
        
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(subtitleTextLabel)
        
        titleTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        subtitleTextLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextLabel.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}
