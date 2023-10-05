//
//  CartViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import UIKit

protocol CartViewProtocol: AnyObject {
    func updateView()
    func updateOrder(quantity: Int, price: Double)
    func showEmptyView()
}

final class CartViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var presenter: CartPresenterProtocol?
    
    // MARK: - Private properties
    
    private let tableView = CartTableView()
    private let orderPriceView = OrderPriceView()
    private lazy var emptyView = EmptyPayoutsView()
    
    private var isSmallOrderView: Bool = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
        presenter?.viewWillAppear()
    }
    
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    
    func updateView() {
        tableView.reloadSections(.init(integer: 1), with: .left)
    }
    
    func updateOrder(quantity: Int, price: Double) {
        if quantity == 0 {
            orderPriceView.isHidden = true
        } else {
            orderPriceView.isHidden = false
            orderPriceView.updateData(quantity: quantity, price: "$ \(price)")
        }
    }
    
    func showEmptyView() {
        clearHandler()
    }
    
}

// MARK: - OrderPriceViewDelegate

extension CartViewController: OrderPriceViewDelegate {
    
    func updateOrderPriceViewSize() {
        orderPriceView.updateButtonSize()
        
        orderPriceView.snp.removeConstraints()
        isSmallOrderView = !isSmallOrderView
        UIView.animate(withDuration: 0.3) { [weak self] in
            if self?.isSmallOrderView == true {
                self?.setSmallSizeOrderView()
            } else {
                self?.setFullSizeOrderView()
            }
            self?.view.layoutIfNeeded()
        }
    }
    
    func didTapBuy() {
        presenter?.userWantToBuy()
    }
    
}

// MARK: - CartTableScrollDelegate

extension CartViewController: CartTableScrollDelegate {
    
    func scrollViewWillBeginDragging() {
        if isSmallOrderView == false {
            updateOrderPriceViewSize()
        }
    }
    
    func scrollViewDidEndDecelerating() {
        updateOrderPriceViewSize()
    }
    
}

// MARK: - Private methods & computed variables

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
        else { configureEmptyView(); return }
        configureTableView()
        configurePriceView()
    }
    
    func configureEmptyView() {
        navigationItem.leftBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        emptyView.configure(message: "Упс!", "Похоже, Ваша корзина пуста..")
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureTableView() {
        tableView.scrollDelegate = self
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
        let actionSheet = UIAlertController(
            title: "Очистка корзины",
            message: "Вы уверены, что хотите очистить корзину?",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(cancelAlertAction)
        actionSheet.addAction(clearAlertActiion)
        present(actionSheet, animated: true)
    }
    
    var cancelAlertAction: UIAlertAction {
        return UIAlertAction(
            title: "Отмена",
            style: .cancel,
            handler: { [weak self] _ in
                self?.dismiss(animated: true)
            }
        )
    }
    
    var clearAlertActiion: UIAlertAction {
        return UIAlertAction(
            title: "Очистить",
            style: .destructive,
            handler: { [weak self] _ in
                self?.clearHandler()
            }
        )
    }
    
    func clearHandler() {
        presenter?.removeAll()
        tableView.isHidden = true
        orderPriceView.isHidden = true
        tableView.removeFromSuperview()
        orderPriceView.removeFromSuperview()
        configureEmptyView()
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
