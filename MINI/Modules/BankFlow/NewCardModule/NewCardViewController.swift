//
//  NewCardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit
import SnapKit

protocol NewCardViewProtocol: AnyObject {
    func setFormTextFields(_ textFields: [FormTableView.FormField])
    func invalidInput(with message: String)
}

final class NewCardViewController: UIViewController {
    
    var presenter: NewCardPresenterProtocol?
    
    private var formTable = FormTableView(frame: .zero, style: .insetGrouped)
    
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
    
    func setFormTextFields(_ textFields: [FormTableView.FormField]) {
        formTable.formFields = textFields
        formTable.reloadData()
    }
    
    func invalidInput(with message: String) {
        showAlert(message: message)
    }
    
}

// MARK: - FormTableDelegate

extension NewCardViewController: FormTableDelegate {
    
    func textFieldDidReturn(_ text: String, from fieldTag: Int) {
        print(text, fieldTag)
    }
    
}

// MARK: - Private extension

private extension NewCardViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "add_new_card_title".localized
        view.insertSubview(formTable, at: 0)
        formTable.frame = view.bounds
        formTable.formDelegate = self
        
        formTable.headerTitle = "Добавление новой карты"
        formTable.footerTitle = "Если введенные данные будут верны - Вы сможете добавить карту в общий список."
    }
    
}
