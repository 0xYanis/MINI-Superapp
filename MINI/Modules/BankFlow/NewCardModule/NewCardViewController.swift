//
//  NewCardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit
import SnapKit

protocol NewCardViewProtocol: AnyObject {
    func updateView(dataIsCorrect: Bool)
    func configureTextFields(_ textFields: [FormTableView.FormField])
    func updateFieldMark(of field: Int, with state: Bool)
    func invalidInput(with message: String)
}

final class NewCardViewController: UIViewController {
    
    var presenter: NewCardPresenterProtocol?
    
    private var formTable = FormTableView(frame: .zero, style: .insetGrouped)
    private var addButton = AddButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
}

// MARK: - NewCardViewProtocol

extension NewCardViewController: NewCardViewProtocol {
    
    func updateView(dataIsCorrect: Bool) {
        addButton.isHidden = !dataIsCorrect
    }
    
    func configureTextFields(_ textFields: [FormTableView.FormField]) {
        formTable.formFields = textFields
        formTable.reloadData()
        addButton.isHidden = true
    }
    
    func invalidInput(with message: String) {
        showAlert(message: message)
    }
    
    func updateFieldMark(of field: Int, with state: Bool) {
        let indexPath = IndexPath(item: field, section: 0)
        formTable.updateCellMark(at: indexPath, with: state)
    }
    
}

// MARK: - FormTableDelegate

extension NewCardViewController: FormTableDelegate {
    
    func textFieldDidReturn(_ text: String, from fieldTag: Int) {
        presenter?.enterText(text, fieldId: fieldTag)
        print(text, fieldTag)
    }
    
}

// MARK: - Private extension

private extension NewCardViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "add_new_card_title".localized
        
        createTable()
        createAddButton()
    }
    
    func createTable() {
        view.insertSubview(formTable, at: 0)
        formTable.frame = view.bounds
        formTable.formDelegate = self
        formTable.headerTitle = "Добавление новой карты"
        formTable.footerTitle = "Если введенные данные будут верны - Вы сможете добавить карту в общий список."
    }
    
    func createAddButton() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        view.insertSubview(addButton, at: 1)
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().inset(55)
            make.width.height.equalTo(60)
        }
        addButton.radiusAndShadow(radius: 30, shadowSize: 15)
    }
    
    @objc func didTapAddButton() {
        presenter?.didTapAddButton()
    }
    
}
