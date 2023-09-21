//
//  CartViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import UIKit
import FloatingPanel

protocol CartViewProtocol: AnyObject {
    
}

final class CartViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var presenter: CartPresenterProtocol?
    
    // MARK: - Private properties
    
    private let tableView = CartTableView()
    private let orderPriceView = OrderPriceView()
    private lazy var emptyView = EmptyPayoutsView()
    private lazy var floatingPanel = FloatingPanelController()
    
    private var isSmallOrderView: Bool = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    
}

// MARK: - Private methods

private extension CartViewController {
    
    func initialize() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem  = clearButton
        navigationItem.rightBarButtonItem = shareButton
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Корзина"
        checkCurrentState()
    }
    
    func checkCurrentState() {
        guard
            let purchases = presenter?.getPurchases(),
            purchases.isEmpty != true
        else { showEmptyView(); return }
        configureTableView()
        configurePriceView()
    }
    
    func showEmptyView() {
        navigationItem.leftBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        emptyView.configure(
            message: "Упс!",
            "Похоже, Ваша корзина пуста..")
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureTableView() {
        tableView.presenter = presenter
        view.insertSubview(tableView, at: 0)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configurePriceView() {
        orderPriceView.delegate = self
        view.addSubview(orderPriceView)
        setSmallSizeOrderView()
        orderPriceView.roundCorners(radius: 15)
        //orderPriceView.updatePrice("$ \(sum)")
    }
    
    var clearButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(clearAction)
        )
    }
    
    var shareButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(shareAction)
        )
    }
    
    @objc func clearAction() {
        presenter?.removeAll()
        tableView.isHidden = true
        orderPriceView.isHidden = true
        tableView.removeFromSuperview()
        orderPriceView.removeFromSuperview()
        showEmptyView()
    }
    
    @objc func shareAction() {
        let items = [Any]()
        let activityVC = UIActivityViewController(
            activityItems: [items],
            applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    func setFullSizeOrderView() {
        orderPriceView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.08)
            make.bottom.equalTo(view.snp.bottomMargin).inset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setSmallSizeOrderView() {
        orderPriceView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.05)
            make.bottom.equalTo(view.snp.bottomMargin).inset(20)
            make.width.equalTo(90)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
}

extension CartViewController: OrderPriceViewDelegate {
    
    func priceButtonAction() {
        orderPriceView.snp.removeConstraints()
        
        if isSmallOrderView {
            UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
                self?.setFullSizeOrderView()
                self?.view.layoutIfNeeded()
            }
            isSmallOrderView = false
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
                self?.setSmallSizeOrderView()
                self?.view.layoutIfNeeded()
            }
            isSmallOrderView = true
        }
    }
    
    
    func didTapBuy() {
        
    }
    
}
