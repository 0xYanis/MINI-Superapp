//
//  BankHistoryLabel.swift
//  MINI
//
//  Created by Yan Rybkin on 19.04.2023.
//

import UIKit
import SnapKit

protocol BankTransactionKeyboardDelegate: AnyObject {
    func userDidBeginUseKeyboard()
    func userDidEndUseKeyboard()
}

final class BankHistoryLabel: UIView {
    
    var delegate: BankTransactionKeyboardDelegate?
    
    private lazy var graberView = UIView()
    private lazy var historyLabel = UILabel(
        text: "Transaction History",
        font: .boldSystemFont(ofSize: 20),
        color: .none
    )
    private lazy var searchButton = UIButton(
        systemImage: "magnifyingglass.circle.fill",
        color: .systemOrange,
        size: 35
    )
    private lazy var searchBar = UISearchBar()
    private var isSearchBarShown = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BankHistoryLabel {
    @objc func searchButtonTapped() {
        historyLabel.alpha = isSearchBarShown ? 1.0 : 0.0
        animateSearchBar(visible: !isSearchBarShown)
        searchButton.alpha = isSearchBarShown ? 1.0 : 0.0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        isSearchBarShown.toggle()
    }
}

private extension BankHistoryLabel {
    func initialize() {
        createGraberView()
        createLabel(label: historyLabel)
        createSearchButton()
        createSearchBar()
    }
    
    func createGraberView() {
        graberView.backgroundColor = .init(white: 0.4, alpha: 0.7)
        graberView.roundCorners(radius: 3)
        addSubview(graberView)
        graberView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(4)
            make.width.equalTo(45)
            make.height.equalTo(6)
        }
    }
    
    func createLabel(label: UILabel) {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    func createSearchButton() {
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        searchButton.addTarget(
            self,
            action: #selector(searchButtonTapped),
            for: .touchUpInside
        )
        
    }
    
    func createSearchBar() {
        searchBar.tintColor = .systemOrange
        searchBar.keyboardType = .webSearch
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search transactions.."
        addSubview(searchBar)
        searchBar.alpha = 0.0
        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func animateSearchBar(visible: Bool) {
        searchBar.isUserInteractionEnabled = visible
        UIView.animate(withDuration: 0.3) {
            self.searchBar.alpha = visible ? 1.0 : 0.0
        }
    }
}

//MARK: - UISearchBarDelegate
extension BankHistoryLabel: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchButtonTapped()
        searchBar.resignFirstResponder()
        delegate?.userDidEndUseKeyboard()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.userDidBeginUseKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //search
    }
}
