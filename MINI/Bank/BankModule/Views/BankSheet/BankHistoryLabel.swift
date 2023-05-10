//
//  BankHistoryLabel.swift
//  MINI
//
//  Created by Yan Rybkin on 19.04.2023.
//

import UIKit
import SnapKit

final class BankHistoryLabel: UIView {
    
    private let historyLabel = UILabel(text: "Transaction History", font: .boldSystemFont(ofSize: 20), color: .none)
    private let searchButton = UIButton(systemImage: "magnifyingglass.circle.fill", color: .systemOrange, size: 35)
    private let searchBar = UISearchBar()
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
        let newTopInset: CGFloat = isSearchBarShown ? 20 : -100
        historyLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(newTopInset)
        }
        animateSearchBar(alphaVisible: !isSearchBarShown)
        isSearchBarShown.toggle()
        searchButton.alpha = isSearchBarShown ? 0.0 : 1.0
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let bankVC = BankViewController()
        if !searchBar.frame.contains(gesture.location(in: bankVC.view)) {
            searchButtonTapped()
        }
    }
}

private extension BankHistoryLabel {
    func initialize() {
        createLabel()
        createSearchButton()
        createSearchBar()
        createTapGesture()
    }
    
    func createLabel() {
        addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
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
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func createSearchBar() {
        searchBar.placeholder = "Search transactions.."
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(25)
            make.right.equalToSuperview().inset(25)
            make.top.bottom.equalToSuperview()
        }
        searchBar.alpha = 0.0
    }
    
    func createTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    func animateSearchBar(alphaVisible: Bool) {
        searchBar.isUserInteractionEnabled = alphaVisible
        UIView.animate(withDuration: 0.4) {
            self.searchBar.alpha = alphaVisible ? 1.0 : 0.0
        }
    }
}
