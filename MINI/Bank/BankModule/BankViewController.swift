//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

protocol BankViewProtocol: AnyObject {
    func updateBankTable()
    func updateHistory()
}

protocol BankViewCellDelegate: AnyObject {
    func handleTapOnCardCell(id: Int)
    func handleTapOnTemplateCell(id: Int)
    func handleTapOnTransactionCell(id: Int)
    func handlePanGesture(_ gesture: UIPanGestureRecognizer)
    func setBigHeightOfHistory()
    func resetBottomSheetSize()
}

protocol BankViewCellDataSource: AnyObject {
    func getCardData() -> [BankCardEntity]
    func getTemplateData() -> [BankTemplateEntity]
    func getTransactionData() -> [BankTransactionEntity]
    
    func searchBarTextDidChange(with searchText: String)
    func getFilteredData() -> [BankTransactionEntity]
}

final class BankViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: BankPresenterProtocol?
    
    //MARK: Private properties
    private lazy var bankTableView  = UITableView()
    private lazy var historyTableVC = BankHistoryViewController()
    private lazy var refreshControl = UIRefreshControl()
    
    private lazy var height: CGFloat    = view.frame.height
    private lazy var minHeight: CGFloat = 0.34 * view.frame.height + view.safeAreaInsets.bottom
    private lazy var maxHeight: CGFloat = view.frame.height - view.safeAreaInsets.top
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
}

//MARK: - BankViewProtocol
extension BankViewController: BankViewProtocol {
    func updateBankTable() {
        bankTableView.reloadData()
    }
    
    func updateHistory() {
        historyTableVC.reloadData()
    }
}

//MARK: - BankViewCellDelegate
extension BankViewController: BankViewCellDelegate {
    func handleTapOnCardCell(id: Int) {
        presenter?.userDidTapCard(index: id)
    }
    
    func handleTapOnTemplateCell(id: Int) {
        presenter?.userDidTapTemplate(id: id)
    }
    
    func handleTapOnTransactionCell(id: Int) {
        presenter?.userDidTapTransaction(id: id)
    }
    
    func setBigHeightOfHistory() {
        historyTableVC.view.animateToSuperviewSize()
    }
    
    func resetBottomSheetSize() {
        historyTableVC.view.resetToOriginalState(with: true)
    }
}

//MARK: - BankViewCellDataSource
extension BankViewController: BankViewCellDataSource {
    func getCardData() -> [BankCardEntity] {
        presenter?.getCardData() ?? []
    }
    
    func getTemplateData() -> [BankTemplateEntity] {
        presenter?.getTemplateData() ?? []
    }
    
    func getTransactionData() -> [BankTransactionEntity] {
        presenter?.getTransactionData() ?? []
    }
    
    func searchBarTextDidChange(with searchText: String) {
        presenter?.searchBarTextDidChange(with: searchText)
    }
    
    func getFilteredData() -> [BankTransactionEntity] {
        presenter?.getFilteredData() ?? []
    }
}

//MARK: - Private methods
private extension BankViewController {
    func initialize() {
        createNavigation(title: "bank_navbar".localized)
        createTableView(bankTableView)
        createTableViewRegisters(in: bankTableView)
        createBottomSheet()
        createRefreshControl(scrollView: bankTableView)
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationItem.rightBarButtonItem = createRightBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    var createRightBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(
            systemItem: .compose,
            primaryAction: .none,
            menu: createRightMenu
        )
    }
    
    var createRightMenu: UIMenu {
        let cardImage = UIImage(systemName: "creditcard.fill")
        let addCard = UIAction(
            title: "add_new_card".localized,
            image: cardImage) { [weak self] _ in
                self?.presenter?.userDidTapNewCard()
            }
        let templateImage = UIImage(systemName: "plus.rectangle.fill")
        let addTemplate = UIAction(
            title: "add_new_template".localized,
            image: templateImage) { [weak self] _ in
                self?.presenter?.userDidTapNewTemplate()
            }
        return UIMenu(children: [addCard, addTemplate])
    }
    
    func createTableView(_ tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.separatorColor = .none
        tableView.backgroundColor = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func createTableViewRegisters(in tableView: UITableView) {
        tableView.register(BankCardSet.self, forCellReuseIdentifier: BankCardSet.cellId)
        tableView.register(BankTemplateLabelCell.self, forCellReuseIdentifier: BankTemplateLabelCell.cellId)
        tableView.register(BankTemplateSet.self, forCellReuseIdentifier: BankTemplateSet.cellId)
    }
    
    func createBottomSheet() {
        addChild(historyTableVC)
        view.addSubview(historyTableVC.view)
        historyTableVC.didMove(toParent: self)
        historyTableVC.delegate = self
        historyTableVC.dataSource = self
        historyTableVC.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.34)
                .offset(tabBarController?.tabBar.frame.height ?? 0)
        }
        historyTableVC.view.layer.cornerRadius = 30
        historyTableVC.view.clipsToBounds = true
    }
    
    func createRefreshControl(scrollView: UIScrollView) {
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
}

//MARK: - Action private methods
private extension BankViewController {
    @objc func didTapSeeAllButt() {
        presenter?.userDidTapSeeAll()
    }
    
    @objc func refreshAction() {
        presenter?.viewDidLoaded()
        presenter?.updateView()
        refreshControl.endRefreshing()
    }
}

//MARK: - Animation methods
extension BankViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
    
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let yTranslation = translation.y
        
        switch gesture.state {
            
        case .changed:
            let newHeight = calculateNewHeight(
                currentHeight: height,
                yTranslation: yTranslation
            )
            updateHistoryTableHeight(newHeight: newHeight)
            animateHeightChange(newHeight: newHeight)
            
        case .ended:
            let destinationHeight = calculateDestinationHeight(
                maxHeight: maxHeight,
                minHeight: minHeight
            )
            updateHistoryTableHeight(newHeight: destinationHeight)
            animateHeightChange(newHeight: destinationHeight)
            
        default:
            break
        }
    }
    
    private func calculateNewHeight(
        currentHeight: CGFloat,
        yTranslation: CGFloat
    ) -> CGFloat {
        let newHeight = max(minHeight, min(maxHeight, currentHeight - yTranslation))
        return newHeight
    }
    
    private func updateHistoryTableHeight(newHeight: CGFloat) {
        historyTableVC.view.snp.remakeConstraints { make in
            make.height.equalTo(newHeight)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func animateHeightChange(newHeight: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.height = newHeight
            self.view.layoutIfNeeded()
        }
    }
    
    private func calculateDestinationHeight(
        maxHeight: CGFloat,
        minHeight: CGFloat
    ) -> CGFloat {
        let isFixed = height >= maxHeight
        return isFixed ? maxHeight : minHeight
    }
}

//MARK: - UITableViewDataSource
extension BankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankCardSet.cellId,
                for: indexPath) as? BankCardSet else { return defaultCell }
            cell.delegate = self
            cell.dataSource = self
            cell.reloadData()
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTemplateLabelCell.cellId,
                for: indexPath) as? BankTemplateLabelCell else { return defaultCell }
            cell.seeAllButt.addTarget(self, action: #selector(didTapSeeAllButt), for: .touchUpInside)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTemplateSet.cellId,
                for: indexPath) as? BankTemplateSet else { return defaultCell }
            cell.delegate = self
            cell.dataSource = self
            cell.reloadData()
            return cell
            
        default:
            return defaultCell
        }
    }
}

//MARK: - UITableViewDelegate
extension BankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height
        switch indexPath.row {
        case 0:
            return (height/5)
        case 1:
            return (height/30)
        case 2:
            return (height/6.3)
        default:
            return tableView.rowHeight
        }
    }
}
