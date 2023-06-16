//
//  ProductViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit
import SnapKit

protocol ProductViewProtocol: AnyObject {
    func updateView()
}

final class ProductViewController: UIViewController {
    
    var presenter: ProductPresenterProtocol?
    
    private lazy var backView = UIView()
    private lazy var cancelButton = UIButton(
        systemImage: "xmark.circle.fill",
        color: .systemOrange,
        size: 35
    )
    private lazy var priceView = UIView()
    private lazy var priceLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        initialize()
    }
    
}

extension ProductViewController: ProductViewProtocol {
    func updateView() {
        createNavigaion(with: "Product")
    }
}

private extension ProductViewController {
    func initialize() {
        view.backgroundColor = .systemGray2
        createBackView()
        createPriceView()
    }
    
    func createNavigaion(with title: String) {
        navigationItem.title = title
    }
    
    func createBackView() {
        backView.backgroundColor = .black
        backView.roundCorners(radius: 25)
        view.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(7)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        createCancelButton()
    }
    
    func createCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonAction),
            for: .touchUpInside
        )
    }
    
    func createPriceView() {
        priceView.backgroundColor = .systemOrange
        priceView.roundCorners(radius: 25)
        view.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(7)
            make.bottom.equalToSuperview()
            make.top.equalTo(backView.snp.bottom).offset(7)
        }
        createPriceLabel()
    }
    
    func createPriceLabel() {
        priceLabel.text = "$ 59.9"
        priceLabel.shadow(color: .black, opacity: 0.5, radius: 10)
        priceLabel.font = .boldSystemFont(ofSize: 25)
        priceLabel.textColor = .white
        priceView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
    }
}

//MARK: - Private action methods
private extension ProductViewController {
    @objc func cancelButtonAction() {
        dismiss(animated: true)
    }
}
