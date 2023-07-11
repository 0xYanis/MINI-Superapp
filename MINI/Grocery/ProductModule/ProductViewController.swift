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
    
    private lazy var imageView    = UIImageView()
    private lazy var productLabel = UILabel()
    
    private lazy var backView     = UIView()
    private lazy var cancelButton = UIButton(
        systemImage: "xmark.circle.fill",
        color: .systemOrange,
        size: 35
    )
    private lazy var priceView  = UIView()
    private lazy var priceLabel = UILabel()
    private lazy var lessButton = UIButton(
        systemImage: "minus",
        color: .white,
        size: 25
    )
    private lazy var moreButton = UIButton(
        systemImage: "plus",
        color: .white,
        size: 25
    )
    
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
        view.backgroundColor = .back2MINI
        createBackView()
        createPriceView()
    }
    
    func createNavigaion(with title: String) {
        navigationItem.title = title
    }
    
    func createBackView() {
        backView.backgroundColor = .backMINI
        backView.roundCorners(radius: 25)
        view.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(7)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        createCancelButton()
        createImageView()
        createProductLabel()
    }
    
    func createImageView() {
        imageView.image = UIImage(named: "burger")
        imageView.contentMode = .scaleAspectFill
        
        backView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            make.width.height.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    func createProductLabel() {
        productLabel.font = .boldSystemFont(ofSize: 20)
        productLabel.numberOfLines = 2
        productLabel.textColor = .front2MINI
        productLabel.text = "Double big-mac with extra deep cheese"
        
        backView.addSubview(productLabel)
        productLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(30)
        }
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
        priceView.backgroundColor = .tintMINI
        priceView.roundCorners(radius: 25)
        
        view.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(7)
            make.bottom.equalToSuperview()
            make.top.equalTo(backView.snp.bottom).offset(7)
        }
        
        createPriceLabel()
        createMoreAndLessButtons()
    }
    
    func createPriceLabel() {
        priceLabel.text = "$ 59.9"
        priceLabel.shadowOffset = .init(width: 10, height: 10)
        priceLabel.font = .boldSystemFont(ofSize: 25)
        priceLabel.textColor = .white
        
        priceView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
        let tapGesture = UIGestureRecognizer(
            target: self,
            action: #selector(priceTapAction)
        )
        priceLabel.addGestureRecognizer(tapGesture)
    }
    
    func createMoreAndLessButtons() {
        lessButton.addTarget(
            self,
            action: #selector(lessButtonAction),
            for: .touchUpInside
        )
        priceView.addSubview(lessButton)
        lessButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(30)
        }
        
        moreButton.addTarget(
            self,
            action: #selector(moreButtonAction),
            for: .touchUpInside
        )
        priceView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(30)
        }
    }
    
}

//MARK: - Private action methods
private extension ProductViewController {
    @objc func cancelButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func priceTapAction() {
        
    }
    
    @objc func lessButtonAction() {
        
    }
    
    @objc func moreButtonAction() {
        
    }
    
}
