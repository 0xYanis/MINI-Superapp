//
//  FormTableView.swift
//  MINI
//
//  Created by Yanis on 20.10.2023.
//

import UIKit
import SwiftUI

protocol FormTableDelegate: AnyObject {
    func textFieldDidReturn(_ text: String, from fieldTag: Int)
}

final class FormTableView: UITableView {
    
    // MARK: - Public properties
    
    public weak var formDelegate: FormTableDelegate?
    public var formFields = [FormField]()
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(FormCell.self, forCellReuseIdentifier: String(describing: FormCell.self))
        dataSource = self
        rowHeight = 60
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - FormField Model
    
    struct FormField {
        var title: String
        var placeholder: String
    }
    
}

// MARK: - FormTextDelegate

extension FormTableView: FormTextDelegate {
    
    func textFieldDidReturn(_ text: String, from fieldTag: Int) {
        formDelegate?.textFieldDidReturn(text, from: fieldTag)
    }
    
}

// MARK: - UITableViewDataSource

extension FormTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        formFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addCell(FormCell.self, indexPath: indexPath)
        cell.configure(with: formFields[indexPath.row], tag: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    private func addCell<C: UITableViewCell>(_ cell: C.Type, indexPath: IndexPath) -> C {
        guard
            let cell = dequeueReusableCell(
                withIdentifier: String(describing: cell),
                for: indexPath) as? C
        else { fatalError("Error with Form Table cell \(cell)") }
        return cell
    }
    
}
