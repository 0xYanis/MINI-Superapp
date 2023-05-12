//
//  CardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

protocol CardViewProtocol: AnyObject {
    
}

final class CardViewController: UIViewController {
    
    private let cardView = CardDetailView()
    private let detailTableView = UITableView(frame: .zero, style: .plain)
    
    var presenter: CardPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

extension CardViewController: CardViewProtocol {
    
}

// MARK: - private methods
private extension CardViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation(title: "Visa Classic")
        createCardView(uiView: cardView)
        createTableView(tableView: detailTableView, cardView)
        
        addButtonsToNavBar()
        createViewRotation(uiView: cardView)
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
    }
    
    func createCardView(uiView: UIView) {
        view.addSubview(uiView)
        uiView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    func createTableView(tableView: UITableView,_ topView: UIView) {
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(40)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - Navigation Bar buttons
private extension CardViewController {
    func addButtonsToNavBar() {
        navigationItem.rightBarButtonItem = createRightBarButtonItem
        navigationItem.leftBarButtonItem = createLeftBarButtonItem
    }
    
    var createRightBarButtonItem: UIBarButtonItem {
        let editButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(rightButtonAction)
        )
        editButton.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.systemOrange],
            for: .normal)
        
        return editButton
    }
    
    var createLeftBarButtonItem: UIBarButtonItem {
        let deleteButton = UIBarButtonItem(
            title: "Delete",
            style: .plain,
            target: self,
            action: #selector(leftButtonAction)
        )
        deleteButton.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.systemOrange],
            for: .normal)
        
        return deleteButton
    }
    
    @objc func rightButtonAction() {
        
    }
    
    @objc func leftButtonAction() {
        let alert = UIAlertController(
            title: "Внимание",
            message: "Вы уверены что хотите удалить карту?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) in
            self.presenter?.userWantToDeleteCard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
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
            rotateView(uiView: cardView, duration: 0.4)
        case .left:
            rotateView(uiView: cardView, duration: 0.4)
        default:
            break
        }
    }
    
    func rotateView(uiView: UIView, duration: Double = 1.0) {
        let rotationTransform = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationTransform.fromValue = 0.0
        rotationTransform.toValue = CGFloat(.pi * 1.0)
        rotationTransform.duration = duration
        rotationTransform.repeatCount = .zero
        uiView.layer.add(rotationTransform, forKey: nil)
    }
}

// MARK: - UITableViewDataSource
extension CardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        defaultCell.selectionStyle = .none
        defaultCell.backgroundColor = .clear
        defaultCell.textLabel?.text = "Visa classic: \(indexPath.row)"
        defaultCell.detailTextLabel?.text = "Some label"
        defaultCell.imageView?.image = UIImage(systemName: "globe")
        return defaultCell
    }
    
    
}
