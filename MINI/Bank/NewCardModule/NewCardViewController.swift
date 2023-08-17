//
//  NewCardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit
import SnapKit

protocol NewCardViewProtocol: AnyObject {
    func userCanSaveNewCard()
    func cardIsInvalid(_ message: String)
}

final class NewCardViewController: UIViewController {
    
    var presenter: NewCardPresenterProtocol?
    
    private lazy var cardFormView = CardFormView()
    private lazy var saveButton = UIButton(
        label: "  Create  ",
        color: .tintMINI,
        cornerRadius: 15
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
}

// MARK: - NewCardViewProtocol
extension NewCardViewController: NewCardViewProtocol {
    
    func userCanSaveNewCard() {
        saveButton.addTarget(
            self,
            action: #selector(handleTapOnSaveButton),
            for: .touchUpInside)
        saveButton.layer.opacity = 1.0
    }
    
    func cardIsInvalid(_ message: String) {
        
    }
    
}

// MARK: - Private extension
private extension NewCardViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "add_new_card_title".localized
        createCardFormView()
        createTapGesture()
        createSaveButton()
    }
    
    func createCardFormView() {
        cardFormView.presenter = presenter
        cardFormView.backgroundColor = .clear
        
        view.addSubview(cardFormView)
        cardFormView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    func createSaveButton() {
        saveButton.layer.opacity = 0.6
        saveButton.addPulseAnimation()
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(70)
            make.right.equalToSuperview().inset(25)
        }
    }
    
    func createTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapOffTheField)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapOffTheField() {
        cardFormView.handleTapOffTheField()
    }
    
    @objc func handleTapOnSaveButton() {
        presenter?.goToRootView()
    }
    
}
