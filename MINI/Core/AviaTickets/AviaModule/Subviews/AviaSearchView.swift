//
//  AviaSearchView.swift
//  MINI
//
//  Created by Yanis on 03.10.2023.
//

import UIKit
import SnapKit

protocol AviaSearchViewDelegate: AnyObject {
    func set(location: String?,_ state: AviaLocationState)
    func didTapDatePicker()
    func showSearchResults()
}

enum AviaLocationState {
    case from
    case to
}

final class AviaSearchView: UICollectionReusableView {
    
    public weak var delegate: AviaSearchViewDelegate?
    
    private let firstTextField = UITextField()
    private let seconTextField = UITextField()
    
    private let container = UIView()
    private let tableView = MiTableView(frame: .zero, style: .insetGrouped)
    private let dateButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure() {
        
    }
    
    private func initialize() {
        backgroundColor = .midnightBlue.darker.darker
        firstTextField.text = "Пулково, Санкт-Петербург"
        createContainer()
        createTableView()
        createDateButton()
    }
    
    private func createContainer() {
        addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func createTableView() {
        tableView.rowHeight = 44
        tableView.isScrollEnabled = false
        tableView.separatorColor = .white
        tableView.backgroundColor = .none
        tableView.dataSource = self
        container.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(115)
        }
    }
    
    private func createDateButton() {
        dateButton.addTarget(self, action: #selector(dateTapAction), for: .touchUpInside)
        dateButton.setTitle(" Даты", for: .normal)
        dateButton.setImage(.init(systemName: "calendar"), for: .normal)
        dateButton.tintColor = .gray
        dateButton.backgroundColor = .darkGray
        container.addSubview(dateButton)
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(90)
            make.height.equalTo(40)
        }
        dateButton.roundCorners(radius: 8)
    }
    
    @objc private func dateTapAction() {
        delegate?.didTapDatePicker()
    }
    
}

//MARK: - UITextFieldDelegate

extension AviaSearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstTextField:
            delegate?.set(location: textField.text, .from)
            seconTextField.becomeFirstResponder()
        case seconTextField:
            delegate?.set(location: textField.text, .to)
            seconTextField.resignFirstResponder()
            delegate?.showSearchResults()
        default: break
        }
        return true
    }
    
}

//MARK: - UITableViewDataSource

extension AviaSearchView: UITableViewDataSource {
    
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
        case 0:  return makeTextFieldCell(field: firstTextField, "Из города..")
        case 1:  return makeTextFieldCell(field: seconTextField, "Куда летим..")
        default: return UITableViewCell()
        }
    }
    
    private func makeTextFieldCell(
        field: UITextField,
        _ placeholder: String
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .darkGray
        cell.contentView.addSubview(field)
        
        field.delegate = self
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor : UIColor.lightGray])
        field.textColor = .white
        field.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        field.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        return cell
    }
    
    private func makeLabelCell(
        _ label: String?
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = label
        cell.selectionStyle = .none
        return cell
    }
    
}
