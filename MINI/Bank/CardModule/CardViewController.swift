//
//  CardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

protocol CardViewProtocol: AnyObject {
    func updateView(with data: BankCardEntity)
}

final class CardViewController: UIViewController {
    
    private lazy var cardView   = UIView()
    private lazy var frontView  = CardDetailView()
    private lazy var backView   = UIView()
    private lazy var tableView  = UITableView(frame: .zero, style: .insetGrouped)
    private var isFlipped: Bool = false
    
    var presenter: CardPresenterProtocol?
    
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

extension CardViewController: CardViewProtocol {
    func updateView(with data: BankCardEntity) {
        createNavigation(title: data.bankName)
        frontView.configure(with: data)
        tableView.reloadData()
    }
}

// MARK: - private methods
private extension CardViewController {
    func initialize() {
        view.backgroundColor = .init(white: 0.05, alpha: 1)
        
        createCardView()
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
    
    func createCardView() {
        cardView.backgroundColor = .clear
        
        view.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    func createFrontView() {
        cardView.addSubview(frontView)
        frontView.snp.makeConstraints { make in
            make.edges.equalTo(cardView)
        }
    }
    
    func createBackView() {
        backView.isHidden = true
        backView.backgroundColor = .red
        
        cardView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalTo(cardView)
        }
    }
    
    func createTableView() {
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
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
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @objc func leftButtonAction() {
        let alert = UIAlertController(
            title: "delete_card_alert_title".localized,
            message: "delete_card_alert_message".localized,
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "delete_card_alert_delete".localized, style: .destructive) { (_) in
            self.presenter?.userWantToDeleteCard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "delete_card_alert_cancel".localized, style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

// MARK: - Rotation animation CardView
private extension CardViewController {
    func createViewRotation(uiView: UIView) {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        uiView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        uiView.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleSwipe(gestureRecognizer: UISwipeGestureRecognizer) {
        switch gestureRecognizer.direction {
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
        default:
            break
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let card = presenter?.getCardData() else { return cell }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "backColor")
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
            if let holderName = card.holderName {
                cell.textLabel?.text = "Holder Name: \(holderName)"
            }
        case 7:
            cell.textLabel?.text = "Expiration Date: \(card.expirationDate)"
        case 8:
            cell.textLabel?.text = "CVV: \(card.cvv)"
        default:
            break
        }
        return cell
    }
    
    
}
