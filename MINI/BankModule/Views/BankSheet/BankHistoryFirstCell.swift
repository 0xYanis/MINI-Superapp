//
//  BankHistoryFirstCell.swift
//  MINI
//
//  Created by Yan Rybkin on 19.04.2023.
//

import UIKit
import SnapKit

final class BankHistoryFirstCell: UITableViewCell {
    
    static let cellId = "BankHistoryFirstCell"
    
    private let historyLabel = UILabel(text: "Transaction History", font: .boldSystemFont(ofSize: 20), color: .none)
    private let searchButton = UIButton(systemImage: "magnifyingglass.circle.fill", color: .systemOrange, size: 35)
    private let searchBar = UISearchBar()
    private var isSearchBarShown = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BankHistoryFirstCell {
    @objc func searchButtonTapped() {
        if isSearchBarShown {
            historyLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(20)
            }
            animateSearchBar(alphaVisible: !isSearchBarShown)
            isSearchBarShown = false
            searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        } else {
            historyLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(-100)
            }
            animateSearchBar(alphaVisible: !isSearchBarShown)
            isSearchBarShown = true
            searchButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        }
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
}

private extension BankHistoryFirstCell {
    func initialize() {
        createLabel()
        createSearchButton()
        createSearchBar()
    }
    
    func createLabel() {
        contentView.addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    func createSearchButton() {
        contentView.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func createSearchBar() {
        searchBar.placeholder = "Search transactions.."
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(50)
            make.top.bottom.equalToSuperview()
        }
        searchBar.alpha = 0.0
    }
    
    func animateSearchBar(alphaVisible: Bool) {
        searchBar.isUserInteractionEnabled = alphaVisible
        UIView.animate(withDuration: 0.4) {
            self.searchBar.alpha = alphaVisible ? 1.0 : 0.0
        }
    }
}
