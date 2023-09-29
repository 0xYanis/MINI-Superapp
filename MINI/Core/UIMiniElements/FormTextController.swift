//
//  FormTextController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.08.2023.
//

import UIKit
import SnapKit

struct FormText {
    var header: String
    var placeholder: String
    var label: String
    var footer: String
}

final class FormTextController: UIViewController {
    
    private var labels: FormText?
    
    private let tableView = MiTableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    public func configure(labels: FormText) {
        self.labels = labels
        tableView.reloadData()
    }
    
    private func initialize() {
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.margins)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension FormTextController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return labels?.header
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForFooterInSection section: Int
    ) -> String? {
        return labels?.footer
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        2
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.row {
        case 0:  return makeTextFieldCell(labels?.placeholder)
        case 1:  return makeLabelCell(labels?.label)
        default: return UITableViewCell()
        }
    }
    
    private func makeTextFieldCell(_ placeholder: String?) -> UITableViewCell {
        let cell = UITableViewCell()
        let textField = UITextField()
        textField.placeholder = placeholder
        cell.selectionStyle = .none
        cell.contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.width.equalToSuperview()
        }
        return cell
    }
    
    private func makeLabelCell(_ label: String?) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = label
        cell.selectionStyle = .none
        return cell
    }
    
}
