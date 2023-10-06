//
//  CardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

protocol CardViewProtocol: AnyObject {
    func updateView(with data: Card)
}

final class CardViewController: UIViewController {
    
    var presenter: CardPresenterProtocol?
    
    private let cardView  = UIView()
    private let frontView = CardDetailView()
    private let backView  = CardBackDetailView()
    private let tableView = MiTableView(style: .insetGrouped)
    private var isFlipped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
}

// MARK: - CardViewProtocol

extension CardViewController: CardViewProtocol {
    
    func updateView(with data: Card) {
        createNavigation(title: data.bankName)
        frontView.configure(with: data)
        backView.configure(with: data)
        tableView.reloadData()
    }
    
}

// MARK: - private methods
private extension CardViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        cardView.backgroundColor = .none
        
        createFrontView()
        createBackView()
        createTableView()
        
        addButtonsToNavBar()
        createViewRotation(uiView: cardView)
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func createFrontView() {
        cardView.addSubview(frontView)
        frontView.snp.makeConstraints { make in
            make.edges.equalTo(cardView)
        }
    }
    
    func createBackView() {
        backView.isHidden = true
        cardView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalTo(cardView)
        }
    }
    
    func createTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Navigation Bar buttons

private extension CardViewController {
    
    func addButtonsToNavBar() {
        navigationItem.rightBarButtonItems = [
            createEditBarButtonItem, createDeleteBarButtonItem
        ]
    }
    
    var createEditBarButtonItem: UIBarButtonItem {
        let editButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(rightButtonAction)
        )
        return editButton
    }
    
    var createDeleteBarButtonItem: UIBarButtonItem {
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(leftButtonAction)
        )
        return deleteButton
    }
    
    @objc func rightButtonAction() {
        presenter?.userWantToEditCard()
    }
    
    @objc func leftButtonAction() {
        let alert = UIAlertController(
            title: "delete_card_alert_title".localized,
            message: "delete_card_alert_message".localized,
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(
            title: "delete_card_alert_delete".localized,
            style: .destructive
        ) { (_) in
            self.presenter?.userWantToDeleteCard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(
            title: "delete_card_alert_cancel".localized,
            style: .cancel
        )
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

// MARK: - Rotation animation CardView

private extension CardViewController {
    func createViewRotation(uiView: UIView) {
        let swipeRight = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipe)
        )
        swipeRight.direction = .right
        uiView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipe)
        )
        swipeLeft.direction = .left
        uiView.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleSwipe(geture: UISwipeGestureRecognizer) {
        switch geture.direction {
        case .right:
            rotateView(options: [
                .curveEaseOut,
                .transitionFlipFromLeft,
                .showHideTransitionViews
            ])
        case .left:
            rotateView(options: [
                .curveEaseOut,
                .transitionFlipFromRight,
                .showHideTransitionViews
            ])
        default: break
        }
    }
    
    func rotateView(options: UIView.AnimationOptions) {
        isFlipped.toggle()
        let fromView = isFlipped ? frontView : backView
        let toView = isFlipped ? backView : frontView
        
        UIView.transition(
            from: fromView,
            to: toView,
            duration: 0.4,
            options: options
        )
    }
    
}

// MARK: - UITableViewDataSource

extension CardViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 8
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let card = presenter?.getCardData() else { return cell }
        cell.selectionStyle = .none
        cell.backgroundColor = .backMINI
        cell.imageView?.image = UIImage(systemName: "circle.fill")
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Card: \(card.logo)"
        case 1:
            cell.textLabel?.text = "Card Type: \(card.cardType)"
        case 2:
            cell.textLabel?.text = "Amount: \(card.amount)"
        case 3:
            cell.textLabel?.text = "Currency: \(card.currency)"
        case 4:
            cell.textLabel?.text = "Number: \(card.number.formatAsCardNumber())"
        case 5:
            cell.textLabel?.text = "Bank Name: \(card.bankName)"
        case 6:
            cell.textLabel?.text = "Holder Name: \(card.holderName ?? "")"
        case 7:
            cell.textLabel?.text = "Expiration Date: \(card.expirationDate)"
        default:
            break
        }
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension CardViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return cardView
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UIScreen.main.bounds.height * 0.32
    }
    
}
