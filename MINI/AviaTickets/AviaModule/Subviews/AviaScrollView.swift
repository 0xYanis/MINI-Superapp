//
//  AviaScrollView.swift
//  MINI
//
//  Created by Yan Rybkin on 29.05.2023.
//

import UIKit

final class AviaScrollView: UIScrollView {
    
    private lazy var todayView      = UIView()
    private lazy var hotTicketsView = UIView()
    private lazy var museumsView    = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension AviaScrollView {
    func configure() {
        todayView.backgroundColor = .red
        hotTicketsView.backgroundColor = .green
        museumsView.backgroundColor = .blue
        addSubviews(to: todayView, multiply: 0.2, below: nil)
        addSubviews(to: hotTicketsView, multiply: 0.3, below: todayView)
        addSubviews(to: museumsView, multiply: 0.25, below: hotTicketsView)
        ConfigureContentSize(with: 1000)
    }
    
    func addSubviews(to view: UIView, multiply: Double, below previousView: UIView?) {
        addSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(multiply)
            
            if let previousView = previousView {
                make.top.equalTo(previousView.snp.bottom).offset(10)
            } else {
                make.top.equalToSuperview()
            }
        }
    }
    
    func ConfigureContentSize(with height: CGFloat) {
        contentSize = CGSize(
            width: frame.width,
            height: height)
    }
}
