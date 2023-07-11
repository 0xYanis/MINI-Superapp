//
//  CartEmptyView.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import UIKit
import SnapKit
import Lottie

protocol CartViewDelegate: AnyObject {
    func popCartView()
}

final class CartEmptyView: UIView {
    
    weak var delegate: CartViewDelegate?
    
    private var lottie: LottieAnimationView?
    private lazy var label      = UILabel()
    private lazy var backButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    deinit {
        lottie?.stop()
        lottie = nil
    }
    
}

private extension CartEmptyView {
    func initialize() {
        backgroundColor = .back2MINI
        createLottieAnimation(with: "emptyCart")
        createLabel(with: "К сожалению, корзина пуста..")
        createBackButton(with: "Продолжить покупки? 😌")
        
        lottie?.play()
    }
    
    func createLottieAnimation(with name: String) {
        lottie = .init(name: name)
        
        guard let lottie = lottie else { return }
        lottie.loopMode = .loop
        lottie.contentMode = .scaleAspectFit
        addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(300)
            make.width.equalTo(130)
        }
    }
    
    func createLabel(with text: String) {
        guard let lottie = lottie else { return }
        label.font = .systemFont(ofSize: 22)
        label.tintColor = .black
        label.text = text
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(lottie.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func createBackButton(with title: String) {
        backButton.setTitleColor(.tintMINI, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 22)
        backButton.setTitle(title, for: .normal)
        backButton.addTarget(
            self,
            action: #selector(backButtonAction),
            for: .touchUpInside
        )
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func backButtonAction() {
        delegate?.popCartView()
    }

}
