//
//  BankCardSet.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit

final class BankCardSet: UITableViewCell {
    //MARK: Public properties
    weak var delegate: BankViewCellDelegate?
    static let cellId = "BankCardSet"
    
    //MARK: Private properties
    private var collectionView: UICollectionView!
    private let snapLayout = StackFlowLayout()
    
    private var color: UIColor = .black
    private var logo: String   = "visa"
    private var amount: String = "$12.5"
    private var number: String = "*5312"
    
    // MARK: Public methods
    func configure(_ color: UIColor,_ logo: String,_ amount: String,_ number: String) {
        self.color = color
        self.logo = logo
        self.amount = amount
        self.number = number
        collectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension BankCardSet {
    func initialize() {
        createCollectionView()
        addConstraintsOfView()
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: snapLayout
        )
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            BankCardCell.self, forCellWithReuseIdentifier: BankCardCell.cellId
        )
    }
    
    func addConstraintsOfView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.backgroundColor = UIColor(named: "backColor")
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - UICollectionViewDataSource
extension BankCardSet: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BankCardCell.cellId,
            for: indexPath) as? BankCardCell else { return defaultCell }
        cell.configure(color, logo, amount, number)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BankCardSet: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 2.5
        return .init(width: width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.handleTapOnCardCell(id: indexPath.item)
    }
}
